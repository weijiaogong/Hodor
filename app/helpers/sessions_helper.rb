module SessionsHelper
  # Use user instead of judge as user might be admin
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def sign_out_msg()
    cf = nil
    if current_user.role == "judge"
        current_user.scores.each do |score|
          sum = Score.get_score_sum.find(score.id).score_sum
          if sum < 0
            cf = "Note: signing out will release unjudged assignments to available judges"
          end
        end
    end
    return cf
  end
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= Judge.find_by_remember_token(cookies[:remember_token])
  end

  def require_login
    unless signed_in?
      flash[:notice] =  'The page you tried to access requires you to log in'
      redirect_to(signin_path) and return
    end
  end

  def require_admin
    require_login
    unless admin?
      flash[:alert] = 'The page you tried to access requires administrator privileges'
      redirect_to(root_path) and return
      #redirect_to(main_page(current_user)) and return
    end
  end

  def require_correct_user
    id = params[:judge_id]
    id = params[:id] unless id

    unless (id && current_user == Judge.find(id)) || admin?
      flash[:alert] = 'The page you tried to access was that of another judge'
      main_page(current_user)
    end
  end
  
  def superadmin?
    current_user.role == 'superadmin'
  end

  def admin?  #TODO superadmin is more special and does less than admin
      ['admin', 'superadmin'].include?(current_user[:role])
      #current_user == Judge.find_by_name("admin")
  end

  def main_page(judge)
    if admin?
      redirect_to(admin_root_path) and return
    else
      if judge.name && judge.company_name
        redirect_to(judge_path(judge.id))  and return
      else
        redirect_to(judge_register_path(judge.id) ) and return
      end
    end
  end
end
