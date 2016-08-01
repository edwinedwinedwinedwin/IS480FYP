class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in
    redirect_to :controller => 'sessions', :action => 'new' unless current_user
  end

  def after_logged_in
    if !session[:user_id].nil?
      session[:user_id]=nil
      #redirect_to :controller => 'sessions', :action => 'new'
    end
  end

  def authorize_admin
    if current_user==nil   
      redirect_to :controller => 'sessions', :action => 'new'
    else
      if !current_user.is_admin
        redirect_to :controller => 'dashboards', :action => 'index' and return    
      end
    end      
  end

  def authorize_user
    if current_user==nil   
      redirect_to :controller => 'sessions', :action => 'new'
    else
      if current_user.is_admin
        redirect_to :controller => 'admins', :action => 'index' and return      
      end
    end      
  end
end
