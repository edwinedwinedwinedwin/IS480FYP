class ProjectInspirationsController < ApplicationController
  def index
    @projectInspirations = ProjectInspiration.all
  end

  def new
    @projectInspiration = ProjectInspiration.new
    @projectInspiration.project_id = params[:project_id]
  end

  def create
    @projectInspiration = ProjectInspiration.new(project_inspirations_params)
    if @projectInspiration.save
      redirect_to showProject_path(:id => @projectInspiration.project_id) and return
    else
      render 'new'
    end
  end

  def edit
    @projectInspiration = ProjectInspiration.find(params[:id])
  end

  def update
    @projectInspiration = ProjectInspiration.find(params[:id])
    if @projectInspiration.update(project_inspirations_params)
      redirect_to showProject_path(:id => @projectInspiration.project_id) and return
    else
      render 'edit'
    end
  end

  def destroy

    @projectInspiration=ProjectInspiration.find(params[:id])
    projectID = @projectInspiration.project_id
    @projectInspiration.destroy
    redirect_to showProject_path(:id => projectID) and return
  end

  private
  def project_inspirations_params
    params.require(:project_inspiration).permit(:title, :description, :img_url, :caption, :project_id)
  end
end
