class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    render 'new'
   # redirect_to action: "new"
    #user = User.find_by(email: params[:email])    
    #if user and user.authenticate(params[:password])
    #    sessions[:user_id] = user.id
    #    redirect_to dashboard_path
    #else
    #    redirect_to login_url, alert: "Invalid username or password."
    #end
  end

  def authenticate     
    render_url='new' 
    @email=params[:user][:email]
    @password=params[:user][:password]
    @status='failed'
      User.all.each do | userInDB |
        if(userInDB.email==@email && userInDB.password==@password)
          @status='success'
          session[:user_id]=userInDB.id
          redirect_to :controller => 'dashboard', :action => 'index' and return
        end
      end
    if status=='failed'
      #redirect_to "http://www.google.com"
      flash[:alert]="Authentication Failed sia fuck"      
    end  
    redirect_to action: "new" and return
  end

  def destroy
    session[:user_id] = nil
    #redirect_to login_url, alert: "Succesfully Logged Out."
    redirect_to action: "new" and return
  end
end
