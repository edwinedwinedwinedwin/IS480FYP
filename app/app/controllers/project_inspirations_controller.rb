class ProjectInspirationsController < ApplicationController
  def index
    @projectInspirations = ProjectInspiration.all
  end

  def new
    @projectInspiration = ProjectInspiration.new
  end

  def create
    @projectInspiration = ProjectInspiration.new(project_inspirations_params)
    @projectInspiration.project_id = 1
    if @projectInspiration.save
      redirect_to :controller => 'project_inspirations', :action => 'index' and return
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
      redirect_to :controller => 'project_inspirations', :action => 'index' and return
    else
      render 'edit'
    end
  end

  def destroy
      @projectInspiration=ProjectInspiration.find(params[:id])
      @projectInspiration.destroy   
      redirect_to :controller => 'project_inspirations', :action => 'index'    
      #redirect_to :controller => 'project_inspirations', :action => 'index',:id=>session[:project_id] and return
    end

  private
  def project_inspirations_params
    params.require(:project_inspiration).permit(:id, :title, :description, :img_url, :caption, :project_id)
  end
end
