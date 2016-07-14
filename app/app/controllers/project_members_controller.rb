class ProjectMembersController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
  	@projectMembers=ProjectMember.where("project_id =1")  	  	  
  	#@projectMembers=ProjectMember.where("project_id =?",params[:project_id])  	  	  
  end

  def show
  	@project_member = ProjectMember.find(params[:id])
  end

  def new
  	@project_member=ProjectMember.new
  end

  def edit
	@project_member=ProjectMember.find(params[:id])	
  end

  def create
  	@project_member=ProjectMember.new(project_members_params)
  	if @project_member.save
  		redirect_to :controller => 'project_members', :action => 'index' and return
  		#redirect_to :controller => 'project_members', :action => 'index',:id=>session[:project_id] and return
  	else
  		render '/project_members/new' and return
  	end
  end

  def update
  	@project_member=ProjectMember.find(params[:id])
  	if @project_member.update_attributes(project_members_params)
  		redirect_to :controller => 'project_members', :action => 'index' and return
  		#redirect_to :controller => 'project_members', :action => 'index',:id=>session[:project_id] and return
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@project_member=ProjectMember.find(params[:id])
    @project_member.destroy   
    redirect_to :controller => 'project_members', :action => 'index'    
    #redirect_to :controller => 'project_members', :action => 'index',:id=>session[:project_id] and return
  end

  private
  def project_members_params
    params.require(:project_member).permit(:name,:role,:img_url,:project_id)
  end

end
