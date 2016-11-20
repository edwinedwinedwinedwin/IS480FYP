class ProjectMembersController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
    @project_members = ProjectMember.all
  end

  def show
    @project_member = ProjectMember.find(params[:id])
  end

  def new
    @project_member=ProjectMember.new
    @project_member.project_id = params[:project_id]
    @project_member.user.build
  end

  def edit
    @project_member=ProjectMember.find(params[:id])
  end

  def create
    @project_member=ProjectMember.new(params[:project_member])

      user_email= params[:project_member][:email]
      @user = User.find_by_email(user_email)
      error=0
      if @user.blank?
        error=1
      else
        if @user.is_admin
          error=2
        end
      end
      if error==0
        @project_member.user_id = @user.id
        if @project_member.save
          redirect_to showProject_path(:id => @project_member.project_id) and return
        else
          render 'new' and return
        end
      else
        @project_member.errors.add(:base,"The email entered does not belong to a registered user.")
        render 'new' and return

    end

  end

  def update
    @project_member=ProjectMember.find(params[:id])
    if @project_member.update_attributes(project_members_params)
      redirect_to showProject_path(:id => @project_member.project_id) and return
    else
      render 'edit'
    end
  end

  def destroy
    @project_member=ProjectMember.find(params[:id])
    @project_member.destroy
    redirect_to manageProjects_path and return
  end

  def join
    @project_member=ProjectMember.find(params[:id])
    @project_member.project_status_id = 3
    @project_member.save
    redirect_to manageProjects_path and return
  end

  private
  def project_members_params
    params.require(:project_member).permit(:email,:user_id, :second_role,:project_id,:project_status_id)
  end

end