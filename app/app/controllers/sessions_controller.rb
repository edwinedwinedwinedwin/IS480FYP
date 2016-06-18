class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password])
        sessions[:user_id] = user.id
        redirect_to dashboard_path
    else
        redirect_to login_url, alert: "Invalid username or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, alert: "Succesfully Logged Out."
  end
end
