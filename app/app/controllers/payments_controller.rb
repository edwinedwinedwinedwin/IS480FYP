class PaymentsController < ApplicationController
  protect_from_forgery except: [:hook]
  def index
  end
  
  def show
     @payment = Payment.find(params[:id])
  end

  def new
  	 @project_reward = ProjectReward.find(params[:pr_id])  	 
  	 @user = User.find(session[:user_id])  	 
  	 @user_shipping_address = UserShippingAddress.find_by_user_id(@user.id)
  	 @Payment = Payment.new
  end

  def create      
  	@pr=ProjectReward.find(params[:payment][:project_reward_id])
    @projectID=Project.find(@pr.project_id).id
  	@payment = Payment.new(payment_params)  
    if @payment.save
    	#ProjectReward.update(@pr.id,:no_of_rewards=>(@pr.no_of_rewards-1))
    	redirect_to @payment.paypal_url(viewProject_path(@projectID)) and return
    else
    	render 'new'
      #redirect_to makePayment_path(:pr_id=>params[:payment][:pr_id]) and return
    end 
  end 

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      #@payment = Payment.find(params[:invoice])
      #@payment.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  private
  def payment_params
    params.require(:payment).permit(:project_reward_id, :project_reward_name, :amount, :user_id,:user_name,:user_shipping_address_id)
  end

end
