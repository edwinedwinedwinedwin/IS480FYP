class ProjectsController < ApplicationController

  def index
    @Projects = Project.all
  end

  def show
    @Project = Project.find(params[:id])
  end

  def new
    @Project = Project.new
  end

  def create
    @Project = Project.new(projects_params)
    if @Project.save
      redirect_to :controller => 'projects', :action => 'index' and return
    else
      render 'new'
    end
  end

  def edit
    @Project = Project.find(params[:id])
  end

  def update
    @Project = Project.find(params[:id])
    if @Project.update(projects_params)
      redirect_to :controller => 'projects', :action => 'index' and return
    else
      render 'edit'
    end
  end

  private
  def projects_params
    params.require(:projects).permit(:start_date, :end_date, :country, :state, :city, :project_status_id, :project_proposal_id, :user_id)
  end
end
