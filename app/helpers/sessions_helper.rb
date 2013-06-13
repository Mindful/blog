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

  def authenticate?
  	if !current_user.nil?
  		cookies[:remember_token] = { value: current_user.remember_token, expires: 3.days.from_now.utc }
  		true
  	else
  		false
  	end
  end
end
