class ProjectUpdatesController < ApplicationController
  def index
    @ProjectUpdates = ProjectUpdate.all
  end

  def new
    @ProjectUpdate = ProjectUpdate.new
  end

  def create
    @ProjectUpdate = ProjectUpdate.new(project_updates_params)
    @ProjectUpdate.project_id = 1
    @ProjectUpdate.created_on = Time.now
    if @ProjectUpdate.save
      redirect_to :controller => 'project_updates', :action => 'index' and return
    else
      render 'new'
    end
  end

  def edit
    @ProjectUpdate = ProjectUpdate.find(params[:id])
  end

  def update
    @ProjectUpdate = ProjectUpdate.find(params[:id])
    if @ProjectUpdate.update(project_updates_params)
      redirect_to :controller => 'project_updates', :action => 'index' and return
    else
      render 'edit'
    end
  end

  private
  def project_updates_params
    params.require(:project_update).permit(:title, :description, :img_url, :caption)
  end
end
