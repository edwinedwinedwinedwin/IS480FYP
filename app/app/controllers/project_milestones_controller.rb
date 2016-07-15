class ProjectMilestonesController < ApplicationController
	before_filter :logged_in, :authorize_user
  def index
	  #@projectMilestones = ProjectMilestones.where("project_id = ?", params[:project_id])
	  @projectMilestones = ProjectMilestone.where("project_id = 1")
	  
  end

  def new
	  @project_milestone = ProjectMilestone.new
  end

  def edit
	  @project_milestone = ProjectMilestone.find(params[:id])
  end
	
  def create
	  @project_milestone = ProjectMilestone.new(project_milestones_params)
	  if @project_milestone.save      
		  #redirect_to :controller => 'project_milestones', :action => 'index', :id= session[:project_id] and return
		  
		  redirect_to :controller => 'project_milestones', :action => 'index' and return	
		  
	  else 
		  render '/project_milestones/new' and return
	  end
  end
  
  def update
	  @project_milestone = ProjectMilestone.find(params[:id])
	  if @project_milestone.update(project_milestones_params)      
		  #redirect_to :controller => 'project_milestones', :action => 'index', :id= session[:project_id] and return	
		  redirect_to :controller => 'project_milestones', :action => 'index' and return	
	  else 
		  render 'edit'
	  end
	  
  end
  
  def destroy
	@project_milestone=ProjectMilestone.find(params[:id])
    @project_milestone.destroy       
	  #redirect_to :controller => 'project_milestones', :action => 'index',:id=session[:project_id] and return
	  redirect_to :controller => 'project_milestones', :action => 'index' and return
  end
  
	
  private
	
  def project_milestones_params
	  params.require(:project_milestone).permit(:name, :start_date, :end_date, :amount_raised, :target_amount, :project_id)
  end
	
	  
  
	
end
