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
    @current_user ||= Judge.where(remember_token: cookies[:remember_token]).first
  end

  def require_login
    id = params[:judge_id]
    unless (id && current_user == Judge.find(id)) || admin
      flash[:error] = "You must be logged in to access this action"
      redirect_to signin_path
    end
  end

  def admin
    current_user == Judge.find(1)
  end
end
