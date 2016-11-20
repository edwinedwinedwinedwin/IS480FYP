class PaymentsController < ApplicationController
  protect_from_forgery except: [:hook]
  def index
  end
  
  def show
     @payment = Payment.find(params[:id])
  end

  def new     
     @current_milestone = ProjectMilestone.order('start_date ASC').where(:project_id => params[:id]).where.not(:project_status_id => 5).first
     @project_reward = ProjectReward.find(params[:pr_id])    
     @user = User.find(session[:user_id])           
     @user_shipping_addresses = UserShippingAddress.where(:user_id=>session[:user_id])
     @Payment = Payment.new
      if !session[:user_id].nil?

      @session = session[:user_id]
      @project_requests = ProjectMember.where(:user_id => @session, :project_status_id => 2)


      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})

      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})      
    end
  end

  def create           
    @payment = Payment.new(payment_params) 
    @user_shipping_address_id = params[:payment][:user_shipping_address_id]
    if @user_shipping_address_id.nil
      @user_shipping_address = UserShippingAddress.new
      @user_shipping_address.address_line_1 = params[:payment][:address_line_1]
      @user_shipping_address.address_line_2 = params[:payment][:address_line_2]
      @user_shipping_address.country = params[:payment][:country]
      @user_shipping_address.city = params[:payment][:city]
      @user_shipping_address.state = params[:payment][:state]
      @user_shipping_address.postal_code = params[:payment][:postal_code]
      @user_shipping_address.user_id = session[:user_id]
      @user_shipping_address.save        
      @payment.user_shipping_address_id= @user_shipping_address.id
    else
      @payment.user_shipping_address_id= params[:payment][:user_shipping_address_id]
    end
    @pr=ProjectReward.find(params[:payment][:project_reward_id])        
    @projectID=Project.find(@pr.project_id).id

    if @payment.save
      #ProjectReward.update(@pr.id,:no_of_rewards=>(@pr.no_of_rewards-1))
      redirect_to @payment.paypal_url(viewProject_path(@projectID)) and return
    else            
      redirect_to makePayment_path(:pr_id=>@pr.id) and return
    end 
  end 

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @payment = Payment.find(params[:invoice])
      Payment.update(@payment.id,:payment_status=>"Paid")
      #@payment.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  private
  def payment_params
    params.require(:payment).permit(:project_reward_id, :project_reward_name, :amount, :user_id,:user_name,:user_shipping_address_id,:payment_status,:project_id,:project_milestone_id)
  end

end
