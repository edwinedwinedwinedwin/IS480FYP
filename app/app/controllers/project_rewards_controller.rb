class ProjectRewardsController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
    @projectRewards=ProjectReward.all

  end

  def show
    @projectReward = ProjectReward.find(params[:id])
  end

  def new
    @projectReward= ProjectReward.new
    @projectReward.project_id = params[:project_id]
  end

  def edit
    @projectReward=ProjectReward.find(params[:id])
  end

  def create
    @projectReward.new(project_rewards_params)
    pID = @projectReward.project_id
    @projectReward.save
    redirect_to showProject_path(:id => @project_reward.project_id)
  end

  def update
    @projectReward
    if @projectReward.update_attributes(project_rewards_params)
      redirect_to showProject_path(:id => @projectReward.project_id) and return
    else
      render 'edit'
    end
  end

  def destroy
    @projectReward=ProjectReward.find(params[:id])
    @projectReward.destroy
    redirect_to projectRewardsIndex_path and return
  end

  private
  def project_rewards_params
    params.require(:project_reward).permit(:name,:min_amount,:description,:estimated_delivery,:no_of_rewards,:project_id,:img_url)
  end
end