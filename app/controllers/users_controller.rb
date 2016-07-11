class UsersController < ApplicationController

    def new
      @user = User.new #use @user
      render :new
    end



    def create
      @user = User.new(user_params) #use @user instead of user

      if user.save
        login_user!(@user) #don't forget !
        redirect_to cats_url
      else
        flash.now[:errors] = @user.errors.full_messages #remeber this!!! ____
        render :new #render vs redirect_to http://blog.markusproject.org/?p=3313 
      end
    end


    def user_params
      params.require(:user).permit(:user_name, :password)
    end
end
