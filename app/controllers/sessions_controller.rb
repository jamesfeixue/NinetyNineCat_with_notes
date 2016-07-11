class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials( #calling this will ensure_session_token (need after_initialize)
        params[:user][:user_name],
        params[:user][:password]) # params seems to be really powerful http://guides.rubyonrails.org/action_controller_overview.html
    if user.nil?
      flash.now[:errors] = "incorrect!" # don't forget = sign
      # http://guides.rubyonrails.org/action_controller_overview.html
      # redirect_to session_new (incorrect)
      render :new
    else
      login_user!(user) #remember this
      redirect_to cats_url
    end
  end

  def destroy
    logout_user! # different from login_user
    #redirect_to new_session_url
  end


end
