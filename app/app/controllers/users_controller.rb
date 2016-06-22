class UsersController < ApplicationController
  #before_filter :logged_in, only: [:index]
  before_action only: [:show, :edit, :update,:destroy]
  skip_before_action :authorize, only: [:new, :create, :index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to :controller => 'dashboard', :action => 'index' and return
    else
      render 'edit'
    end
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy    
    redirect_to :controller => 'users', :action => 'index' and return
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #flash[:notice]="You have signed up successfully"
      redirect_to :controller => 'dashboard', :action => 'index' and return
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:password,:email,:first_name, :last_name, :address, :is_admin)
  end
end
