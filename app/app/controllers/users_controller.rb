class UsersController < ApplicationController
  before_filter :authorize_admin, only: [:index,:show]
  before_action only: [:show, :edit, :update,:destroy]
  skip_before_action :authorize, only: [:new, :create, :index]

  def changepass
    @user=User.find(params[:id])      
  end

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
      if @user.is_admin
        redirect_to :controller => 'users', :action => 'index' and return
      else
        redirect_to :controller => 'dashboards', :action => 'index' and return  
      end
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
       if @user.is_admin
          if @user.address=='Admin'
            redirect_to :controller => 'admins', :action => 'manage' and return
          else
            redirect_to :controller => 'users', :action => 'index' and return
          end
      else
        redirect_to :controller => 'dashboards', :action => 'index' and return
      end
    else
      if @user.is_admin
        render '/admins/new' and return
      end
      render 'new' and return
    end
  end

  def ban
    @user=User.find(params[:id])
    @user.is_banned=1
    @user.save
    redirect_to :controller => 'users', :action => 'index'    
  end

  def unban
    @user=User.find(params[:id])
    @user.is_banned=0
    @user.save
    redirect_to :controller => 'users', :action => 'index'    
  end

  def removeadmin  
    @user=User.find(params[:id])
    @user.destroy       
    redirect_to :controller => 'admins', :action => 'manage'  
  end

  private
  def user_params
    params.require(:user).permit(:password,:password_confirmation,:email,:first_name, :last_name, :address, :is_admin,:is_banned)
  end
end
