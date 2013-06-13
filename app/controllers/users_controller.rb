class UsersController < ApplicationController

  before_action :signed_in_user
  before_action :correct_user
  #hits everything, but our only two actions are edit and update

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to admin_path
    else
      render 'edit'
    end
   end




  private

    def user_params #this is basically redundant because it permits all params, but I believe rails will error without it
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def signed_in_user
      #redirect_to signin_url, notice: "Please sign in." unless signed_in?	
      redirect_to login_url, error: "Please sign in." unless authenticate?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(admin_path) unless current_user?(@user) #this should redirect to editing yourself
    end
end
