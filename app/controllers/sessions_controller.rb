include PotatoConfiguration
class SessionsController < ApplicationController
  skip_before_action :authenticate
  def new
    @user = User.new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      session[:slug] = user.slug
      redirect_to root_url, notice: "Logged in"
    else
       flash.now.alert = "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:slug] = nil
    redirect_to root_url, notice: "Logged Out"
  end
end
