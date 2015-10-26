class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user.nil?
      render :new
    else
      log_in(@user)    #define
      redirect_to goals_url
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

end
