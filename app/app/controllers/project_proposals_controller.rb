class ProjectProposalsController < ApplicationController
  before_filter :logged_in,:authorize_user,  only: [:manage]
  before_filter :logged_in,:authorize_admin, only: [:accept ,:reject, :index]

  def index
    @projectProposals = ProjectProposal.all
  end

  def new
    @session =session[:user_id]
    @projectProposal = ProjectProposal.new

    if !@session.nil?
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

  end

  def basicinfo
    @ProjectProposal  = ProjectProposal.new
  end

  def step1
    @ProjectProposal = ProjectProposal.new(params_pp_basic)
    unless @ProjectProposal.valid?(:step1)
      @ProjectProposal.errors.each {|k, v| puts "#{k.capitalize}: #{v}"}
      render 'basicinfo'
    else
      redirect_to description_Proposal_path(:title => @ProjectProposal.title, :project_category_id => @ProjectProposal.project_category_id)
    end
  end

  def descriptions
    @ProjectProposal  = ProjectProposal.new(params_pp_basic)
    #@ProjectProposal.title = params[:title]
    #@ProjectProposal.project_category_id = params[:project_category_id]
  end

  def step2
    @ProjectProposal = ProjectProposal.new(params_pp_description)
    unless @ProjectProposal.valid?(:step2)

      @ProjectProposal.errors.each {|k, v| puts "#{k.capitalize}: #{v}"}
      render 'descriptions'
    else
      redirect_to description_Proposal_path(:title => @ProjectProposal.title, :project_category_id => @ProjectProposal.project_category_id)
    end
  end

  def manage
    emailStr = params[:email]
    @projectProposals = ProjectProposal.where(email: emailStr)
  end

  def create
    @projectProposal = ProjectProposal.new(params_pp)
    @projectProposal.project_status_id = 2
    @projectProposal.country=params[:project_proposal][:country]
    img_url = params[:project_proposal][:img_url]
    if  @projectProposal.save
      # upload project proposal images
      if img_url.present?
        img_url.each do |a|
          @ProjectProposalImg = ProjectProposalImg.new(params_pp_img)
          @ProjectProposalImg.project_proposal_id=@projectProposal.id
          @ProjectProposalImg.img_url = a
          @ProjectProposalImg.save
        end
      end
      SysMailer.new_proposal_email(@projectProposal).deliver
      redirect_to successProposalSubmission_path(:id =>  @projectProposal.id)
    else
      @session =session[:user_id]
      if !@session.nil?
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
      render 'new' and return
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
      #@new_password_digest=BCrypt::Password.create(@new_password, :cost => 11) # generate password digest
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
    @ProjectMember.role = 'Founder'
    @ProjectMember.email = @user.email
    @ProjectMember.description = 'Description'
    @ProjectMember.sub_description ='Sub Description'
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
    params.require(:project_proposal).permit(:title, :description, :project_category_id, :name, :email, :country, :creator_title, :estimated_start_date, :estimated_end_date, :company_url, :estimated_amt_raise)
  end

  def params_pp_img
    params.permit(:project_proposal_img).permit(:img_url)
  end

  def params_pp_basic
    params.require(:project_proposal).permit(:title, :project_category_id)
  end

  def params_pp_description
    params.require(:project_proposal).permit(:title, :project_category_id, :description)
  end
end