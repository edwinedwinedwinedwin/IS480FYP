class ExploresController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(:id => params[:id])
   
   	current_User = session[:user_id]

   	checkCreator = ProjectMember.find_by(:user_id => current_User, :project_id => @project.id)

   	if !checkCreator.nil?
   		redirect_to showProject_path(:id => @project.id)
   	end


  end
end
