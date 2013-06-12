class UsersController < ApplicationController
  def edit
  end

  def update
  end


  private

    def user_params #this is basically redundant because it permits all params, but rails will error without it
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
