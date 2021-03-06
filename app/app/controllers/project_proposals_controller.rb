class ProjectProposalsController < ApplicationController
  before_filter :logged_in,:authorize_user,  only: [:manage]
  before_filter :logged_in,:authorize_admin, only: [:accept ,:reject, :index]

  def index
    @projectProposals = ProjectProposal.all
  end

  def new
   @projectProposal = ProjectProposal.new

    @session =session[:user_id]
    if !@session.nil?
      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                project_proposal_imgs.project_proposal_id as pp_id,
                project_proposal_imgs.id as ppi_id,
                project_proposals.title as title,
                projects.id as p_id
                ').joins(project_proposal: :project).where(:projects => {:user_id => @session})

      @user=User.find(@session) # only able to edit current logged in user
    end

  end

  def manage
    emailStr = params[:email]
    @projectProposals = ProjectProposal.where(email: emailStr)
  end

  def create
    @projectProposal = ProjectProposal.new(params_pp)
    @projectProposal.project_status_id = 2
    @projectProposal.country = params[:project_proposal][:country]
    img_url = params[:project_proposal][:img_url]
    if @projectProposal.save
      # upload project proposal images
      if img_url.present?
        img_url.each do |a|
          @ProjectProposalImg = ProjectProposalImg.new(params_pp_img)
          @ProjectProposalImg.project_proposal_id=@projectProposal.id
          @ProjectProposalImg.img_url = a
          if @ProjectProposalImg.save
            #do nothing
          else
            render 'new'
          end
        end
      end
      SysMailer.new_proposal_email(@projectProposal).deliver
      redirect_to successProposalSubmission_path(:id =>  @projectProposal.id)
    else
      render 'new'
    end
  end

  def show
    @projectProposal = ProjectProposal.find(params[:id])
  end

  def successProposal
    @session =session[:user_id]
    @projectProposal = ProjectProposal.find(params[:id])

    if !session[:user_id].nil?
      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      @user=User.find(@session) # only able to edit current logged in user
    end
  end

  def accept
    @projectProposal=ProjectProposal.find(params[:id])
    @projectProposal.project_status_id = 3
    @projectProposal.save

    # Project Proposal will be added to Projects table
    @user = User.find_by_email(@projectProposal.email)
    @new_password=Array.new(8){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join # generate random password

    # Automatically create account for user who submitted project proposal if user not registered
    if !@user.blank?
      SysMailer.accept_proposal_email(@projectProposal).deliver
    else

      @user=User.new
      @user.name=@projectProposal.name
      @user.email=@projectProposal.email
      @user.password=@new_password
      @user.password_confirmation=@new_password
      @user.is_banned = 0
      @user.is_admin = 0
      @user.save
      #Send acceptance email to user who sign up containing new account password
      SysMailer.accept_new_proposal_email(@new_password,@projectProposal).deliver
    end

    @project = Project.new
    @project.project_status_id = 1
    @project.project_proposal_id = @projectProposal.id
    @project.country = @projectProposal.country
    @project.user_id = @user.id
    @project.save
    # Project Founder will be assigned to person who submitted project proposal
    @ProjectMember = ProjectMember.new
    @ProjectMember.role = @projectProposal.creator_title
    @ProjectMember.email = @user.email
    #@ProjectMember.description = 'Description'
    #@ProjectMember.sub_description ='Sub Description'
    @ProjectMember.second_role = 'Creator'
    @ProjectMember.project_id = @project.id
    @ProjectMember.project_status_id = 3
    @ProjectMember.user_id = @user.id
    @ProjectMember.save

    redirect_to adminDashboard_path and return
  end

  def reject
    @projectProposal=ProjectProposal.find(params[:id])
    @projectProposal.project_status_id = 4
    @projectProposal.save
    #Send email to user who sign up
    SysMailer.reject_proposal_email(@projectProposal).deliver
    redirect_to adminDashboard_path and return
  end

  private
  def params_pp
    params.require(:project_proposal).permit(:title, :description, :project_category_id, :name, :email, :creator_title, :estimated_start_date, :estimated_end_date, :company_url, :estimated_amt_raise, :country)
  end

  def params_pp_img
    params.permit(:project_proposal_img).permit(:img_url)
  end

end