class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper #this way it's available everywhere

  before_action :page_setup

  def page_setup
  	@login = authenticate?
  	clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil unless request.url == login_url #clear the return to unless it's login page
  end

  def require_login
  	unless @login
  	  session[:return_to] = request.url #so that we can come back to it once they log in
  	  redirect_to login_path, error: "You must be signed in for that."
  	end
  end

  def require_not_login
    redirect_to root_url if @login
  end


end
