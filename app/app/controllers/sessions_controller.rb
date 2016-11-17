class SessionsController < ApplicationController
  before_filter :after_logged_in
  def new
    flash[:alert]= nil
  end

  def resetpass
    flash[:alert]= nil
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      if user.is_banned
        flash[:alert]="Your account has been banned."
        render 'new'
      else
        session[:user_id] = user.id
        if user.is_admin
          redirect_to adminDashboard_path and return
        else
          @checkProject = Project.where(:user_id => user.id).first
          if @checkProject.nil?
            redirect_to dashboardIndex_path
          else
            redirect_to showProject_path(:id => @checkProject.id)
          end
        end
      end
    else
      flash[:alert]="Invalid email/password."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path and return
  end

end




