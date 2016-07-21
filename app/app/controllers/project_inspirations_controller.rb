class ProjectInspirationsController < ApplicationController
  def index
    @ProjectInspirations = ProjectInspiration.all
  end

  def new
    @ProjectInspiration = ProjectInspiration.new
  end

  def create
    @ProjectInspiration = ProjectInspiration.new(project_inspirations_params)
    @ProjectInspiration.project_id = 1
    if @ProjectInspiration.save
      redirect_to :controller => 'project_inspirations', :action => 'index' and return
    else
      render 'new'
    end
  end

  def edit
    @ProjectInspiration = ProjectInspiration.find(params[:id])
  end

  def update
    @ProjectInspiration = ProjectInspiration.find(params[:id])
    if @ProjectInspiration.update(project_inspirations_params)
      redirect_to :controller => 'project_inspirations', :action => 'index' and return
    else
      render 'edit'
    end
  end

  private
  def project_inspirations_params
    params.require(:project_inspiration).permit(:title, :description, :img_url, :caption)
  end
end
