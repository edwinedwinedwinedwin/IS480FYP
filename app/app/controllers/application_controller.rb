class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in
    redirect_to login_path unless current_user

  end

  def after_logged_in
    if !session[:user_id].nil?
      session[:user_id]=nil
    end
  end

  def authorize_admin
    if current_user==nil   
      redirect_to login_path
    else
      if !current_user.is_admin
       redirect_to dashboardIndex_path and return
      end
    end      
  end

  def authorize_user
    if current_user==nil   
      redirect_to login_path
    else
      if current_user.is_admin
        redirect_to adminDashboard_path and return
      end
    end      
  end
end
