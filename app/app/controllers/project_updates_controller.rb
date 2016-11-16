class ProjectUpdatesController < ApplicationController
  def index
    @ProjectUpdates = ProjectUpdate.all
  end

  def new
    @ProjectUpdate = ProjectUpdate.new
    @ProjectUpdate.project_id = params[:project_id]
  end

  def create
    @ProjectUpdate = ProjectUpdate.new(project_updates_params)
    @ProjectUpdate.created_on = Time.now

    if !params[:img_url].nil?
      @ProjectUpdate.img_url = params{:img_url}
    end

    if @ProjectUpdate.save
      redirect_to showProject_path(:id => @ProjectUpdate.project_id) and return
    end
    
  end

  def edit
    @ProjectUpdate = ProjectUpdate.find(params[:id])
  end

  def update
    @ProjectUpdate = ProjectUpdate.find(params[:id])
    if @ProjectUpdate.update(project_updates_params)
      redirect_to showProject_path(:id => @ProjectUpdate.project_id) and return
    else
      render 'edit'
    end
  end

  private
  def project_updates_params
    params.require(:project_update).permit(:title, :description,:project_id, :img_url)
  end
end