class SessionsController < ApplicationController
  #before_filter :logged_in
  def new
    render 'new'
  end

  def create
    user = User.find_by_email(params[:email])    
    if user and user.authenticate(params[:password])      
        session[:user_id] = user.id
        #if user.is_admin
          redirect_to :controller => 'admins', :action => 'index' and return
        #else
        #  redirect_to :controller => 'dashboards', :action => 'index' and return
        #end        
    else                
        redirect_to action: "new"
    end
  end

  def destroy
    session[:user_id] = nil
    #redirect_to login_url, alert: "Succesfully Logged Out."
    redirect_to action: "new" and return
  end
end




