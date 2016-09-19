class ProjectRewardsController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
    @projectRewards=ProjectReward.all

  end

  def show
    @project_reward = ProjectReward.find(params[:id])
  end

  def new
    @project_reward= ProjectReward.new
    @project_reward.project_id = params[:project_id]
  end

  def edit
  	@project_reward=ProjectReward.find(params[:id])  
  end

  def create
    @project_reward=ProjectReward.new(project_rewards_params)

    pID = @project_reward.project_id
    @project_reward.save
    redirect_to showProject_path(:id => @project_reward.project_id)

  end

  def update
    @project_reward=ProjectReward.find(params[:id])
    if @project_reward.update_attributes(project_rewards_params)
      redirect_to showProject_path(:id => @project_reward.project_id) and return
    else
      render 'edit'
    end
  end

  def destroy
    @project_reward=ProjectReward.find(params[:id])
    @project_reward.destroy   
    #redirect_to :controller => 'project_rewards', :action => 'index' and return
    redirect_to projectRewardsIndex_path and return
    #redirect_to :controller => 'project_rewards', :action => 'index',:id=session[:project_id] and return
  end

  private
  def project_rewards_params
    params.require(:project_reward).permit(:name,:min_amount,:description,:estimated_delivery,:no_of_rewards,:project_id,:img_url)
  end
end
