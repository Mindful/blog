module SessionsHelper
  
  def sign_in(user)
    cookies[:remember_token] = { value:   user.remember_token, expires: 3.days.from_now.utc }
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token]) 
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def authenticate?
  	if !current_user.nil?
  		cookies[:remember_token] = { value: current_user.remember_token, expires: 3.days.from_now.utc }
  		true
  	else
  		false
  	end
  end

  def require_login
  	unless authenticate?
  	  session[:return_to] = request.url #so that we can come back to it once they log in
  	  redirect_to login_path, error: "You must be signed in for that."
  	end
  end

  def require_correct_user
  	@user = User.find(params[:id])
    redirect_to(edit_user_path(current_user)) unless current_user?(@user) #redirect to your own edit page if you try and do something to someone else's
  end

  def require_not_login
  	redirect_to root_url unless !authenticate?
  end


end
