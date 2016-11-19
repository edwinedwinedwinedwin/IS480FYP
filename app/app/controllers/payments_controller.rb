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
  	 #@user_shipping_addresses = UserShippingAddress.where(:user_id=>@user.id)
     @user_shipping_address = UserShippingAddress.find_by_user_id(@user.id)
  	 @Payment = Payment.new
  end

  def create        
  	@pr=ProjectReward.find(params[:payment][:project_reward_id])        
    @projectID=Project.find(@pr.project_id).id
  	@payment = Payment.new(payment_params)  
    #if params[:payment][:amount]<@pr.min_amount
    #  flash[:alert]="Amount cannot be less than ".to_s+@pr.min_amount.to_s
    #  render 'new'      
    #end
    
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
