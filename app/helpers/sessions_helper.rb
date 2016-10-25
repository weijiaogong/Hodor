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

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= Judge.find_by_remember_token(cookies[:remember_token])
  end

  def require_login
    unless signed_in?
      redirect_to signin_path, :notice => 'The page you tried to access requires you to log in'
    end
  end

  def require_admin
    require_login
    unless admin?
      redirect_to main_page(current_user), :alert => 'The page you tried to access requires administrator privileges'
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

  def admin?
    # current_user == Judge.find(1)
    current_user == Judge.find_by_name("admin")
  end

  def main_page(judge)
    if admin?
      redirect_to admin_root_path
    else
      if judge.name && judge.company_name
        redirect_to judge_path(judge.id)
      else
        redirect_to judge_register_path(judge.id)
      end
    end
  end
end
