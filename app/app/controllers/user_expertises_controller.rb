class UserExpertisesController < ApplicationController
  def index
  	@userExpertises=UserExpertise.all  	
  end

  def new
  	@user_expertise =UserExpertise.new
    @project_id = params[:project_id]
    @user_id = params[:user_id]

  end

  def show
  	@user_expertise=UserExpertise.find(params[:id])
  end

  def create
  	@user_expertise=UserExpertise.new(user_expertises_params)
  	@user_expertise.save
    redirect_to showProject_path(:id => params[:project_id]) and return
  end

  def destroy
  	@user_expertise=UserExpertise.find(params[:id])
  	@user_expertise.destroy
  	redirect_to :controller => 'user_expertises', :action => 'index'
  end

  private
  def user_expertises_params
  	params.require(:user_expertise).permit(:expertise_name,:user_id)
  end
end