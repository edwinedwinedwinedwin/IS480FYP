class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update,:destroy]
  skip_before_action :authorize, only: [:new, :create, :index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path , :notice => 'Successful.'
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username,:email, :password, :first_name, :last_name, :address, :is_admin)
  end
end
