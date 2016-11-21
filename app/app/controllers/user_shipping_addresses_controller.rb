class UserShippingAddressesController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index    
    @userShippingAddresses=UserShippingAddress.where(:user_id=>session[:user_id])
    if !session[:user_id].nil?
      @session = session[:user_id]
      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      @user = User.find(session[:user_id])
    end
  end

  def show
    @userShippingAddress = UserShippingAddress.find(params[:id])
  end

  def new
    @session = session[:user_id]
    @user_shipping_address=UserShippingAddress.new
    if !session[:user_id].nil?
      @session = session[:user_id]
      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      @user = User.find(session[:user_id])
    end
  end

  def edit    
  	@user_shipping_address=UserShippingAddress.find(params[:id])
    if !session[:user_id].nil?
      @session = session[:user_id]
      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      @user = User.find(session[:user_id])
    end
  end

  def create    
    @user_shipping_address=UserShippingAddress.new(user_shipping_address_params)
    #@user_shipping_address.country=params[:country]
    if @user_shipping_address.save
      redirect_to manageShippingAddress_path and return
      #redirect_to :controller => 'user_shipping_address', :action => 'index',:id=session[:project_id] and return
    else
      render addShippingAddress_path and return
    end
  end

  def update
    @user_shipping_address=UserShippingAddress.find(params[:id])
    if @user_shipping_address.update_attributes(user_shipping_address_params)
    	redirect_to manageShippingAddress_path and return
      #redirect_to :controller => 'user_shipping_address', :action => 'index',:id=session[:project_id] and return
    else
      render updateShippingAddress_path and return
    end
  end

  def destroy
    @user_shipping_address=UserShippingAddress.find(params[:id])
    @user_shipping_address.destroy   
    redirect_to manageShippingAddress_path and return
    #redirect_to :controller => 'user_shipping_address', :action => 'index',:id=session[:project_id] and return
  end

  private
  def user_shipping_address_params
    params.require(:user_shipping_address).permit(:address_line_1,:address_line_2,:country,:postal_code,:user_id)
  end
end
