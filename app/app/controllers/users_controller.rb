class UsersController < ApplicationController
  before_filter :authorize_admin, only: [:index,:show]
  before_action only: [:show, :edit, :update,:destroy]
  skip_before_action :authorize, only: [:new, :create, :index]

  def changepass
    current_user_id=session[:user_id]      
    @user=User.find(current_user_id)
    # only able to change own account password

    @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>current_user_id})
    @project_coverImgs = ProjectProposalImg.select('
                project_proposal_imgs.project_proposal_id as pp_id,
                project_proposal_imgs.id as ppi_id,
                project_proposals.title as title,
                projects.id as p_id
                ').joins(project_proposal: :project).where(:projects => {:user_id => current_user_id})
    #@project_coverImgs = ProjectProposalImg.select("*").joins(:project_proposal).where(:project_proposal_imgs => {:project_proposal_id => @project.project_proposal_id} )

    @user=User.find(current_user_id) # only able to edit current logged in user
  end

  def resetpass    
    @first_name=User.find_by_first_name(params[:first_name])
    @last_name=User.find_by_last_name(params[:last_name])
    @user = User.find_by_email(params[:email])
    if @user.nil?
      flash[:alert]='You have entered an invalid email.'
      redirect_to userResetPassword_path
    else
      if @first_name.nil? || @last_name.nil?
        flash[:alert]='You have entered an invalid input.'        
        redirect_to userResetPassword_path
      end
      new_password=Array.new(8){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join # generate random password
      new_password_digest=BCrypt::Password.create(new_password, :cost => 11) # generate password digest
      User.update(@user.id,:password_digest=>new_password_digest)
      SysMailer.reset_password_email(@user,new_password).deliver            
      redirect_to login_path
    end    
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    current_user_id=session[:user_id]
    session[:project_id] = nil
    @user=User.find(current_user_id) # only able to edit current logged in user
    @session=session[:user_id]
    @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
    @project_coverImgs = ProjectProposalImg.select('
                project_proposal_imgs.project_proposal_id as pp_id,
                project_proposal_imgs.id as ppi_id,
                project_proposals.title as title,
                projects.id as p_id
                ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
    #@project_coverImgs = ProjectProposalImg.select("*").joins(:project_proposal).where(:project_proposal_imgs => {:project_proposal_id => @project.project_proposal_id} )

    @user=User.find(@session) # only able to edit current logged in user

  end

  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])    
    if @user.update(user_params)      
        if @user.is_admin
          redirect_to adminDashboard_path and return
        else
          @projectSession = session[:project_id]
          if @projectSession.nil?
            redirect_to dashboardIndex_path and return
          else
            redirect_to showProject_path(:id => @projectSession)
          end
        end
    else
        render Rails.application.routes.recognize_path(request.referer)[:action] #renders previous get request
    end
  end

  def destroy
    @user=User.find(params[:id])
    if @user.is_admin
      @user.destroy
      redirect_to  adminManage_path
    else
      @user.destroy
      redirect_to  userIndex_path
    end

  end

  def create
    @user = User.new(user_params)
    @user.is_banned = 0

    #User Save to Database
    if @user.save
      #Check User is a Normal user or an Admin user
      if @user.is_admin
        redirect_to adminManage_path and return
      else
          #Send email to user who sign up
          SysMailer.welcome_email(@user).deliver                
          redirect_to login_path
      end
    else
      if @user.is_admin
        render '/admins/new' and return
      else
        render 'new' and return
      end
    end
  end

  def manage
      @user = User.find(params[:id])
      @projects = Project.joins(:project_proposal).where(:project_proposals => {:email=> @user.email, :project_status_id=>3})
  end

  def updateProfilePic
    @user=User.find(params[:id])
    if !params[:user].nil? && !params[:user][:profile_pic].nil?
      @user.profile_pic = params[:user][:profile_pic]
      @user.save
    end
    checkProjectExist=Project.find_by_user_id(@user.id)
    if checkProjectExist.nil?
      redirect_to dashboardIndex_path
    else      
      redirect_to showProject_path(:id => checkProjectExist.id)
    end
  end

  def ban
    @user=User.find(params[:id])
    @user.is_banned=1
    @user.save
    redirect_to userIndex_path
  end

  def unban
    @user=User.find(params[:id])
    @user.is_banned=0
    @user.save
    redirect_to userIndex_path

  end


  private
  def user_params
    params.require(:user).permit(:password,:password_confirmation,:email,:first_name, :last_name,:profile_pic,:is_admin,:bio_url, :fb_url, :twitter_url, :instagram_url,:city,:state,:country)
  end
end
