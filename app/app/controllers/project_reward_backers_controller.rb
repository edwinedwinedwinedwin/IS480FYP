class ProjectRewardBackersController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
    @projectRewardBackers=ProjectRewardBacker.all
    #@projectRewardBackers=ProjectRewardBacker.where("project_id =?",params[:project_id])    
  end

  def show
    @projectRewardBackers = ProjectRewardBacker.find(params[:id])
  end

  def new
    @project_reward_backer=ProjectRewardBacker.new
  end

  def edit
  	@project_reward_backer=ProjectRewardBacker.find(params[:id])  
  end

  def create
    @project_reward_backer=ProjectRewardBacker.new(project_reward_backers_params)
    if @project_reward_backer.save
      redirect_to :controller => 'project_reward_backers', :action => 'index' and return
      #redirect_to :controller => 'project_reward_backers', :action => 'index',:id=session[:project_id] and return
    else
      render '/project_reward_backer/new' and return
    end
  end

  def update
    @project_reward_backer=ProjectRewardBacker.find(params[:id])
    if @project_reward_backer.update_attributes(project_reward_backers_params)
    	redirect_to :controller => 'project_reward_backers', :action => 'index' and return
      #redirect_to :controller => 'project_reward_backers', :action => 'index',:id=session[:project_id] and return
    else
      render 'edit'
    end
  end

  def destroy
    @project_reward_backer=ProjectRewardBacker.find(params[:id])
    @project_reward_backer.destroy   
    redirect_to :controller => 'project_reward_backers', :action => 'index' and return
    #redirect_to :controller => 'project_reward_backers', :action => 'index',:id=session[:project_id] and return
  end

  private
  def project_reward_backers_params
    params.require(:project_reward_backer).permit(:amount_funded,:user_shipping_address_id,:user_id,:project_reward_id)
  end
end
