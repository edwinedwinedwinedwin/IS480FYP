class UserShippingAddressesController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
    @userShippingAddresses=UserShippingAddress.all   
    #@userShippingAddresses=UserShippingAddress.where("project_id =?",params[:project_id])    
  end

  def show
    @userShippingAddress = UserShippingAddress.find(params[:id])
  end

  def new
    @user_shipping_address=UserShippingAddress.new
  end

  def edit
  	@user_shipping_address=UserShippingAddress.find(params[:id])  
  end

  def create
    @user_shipping_address=UserShippingAddress.new(user_shipping_address_params)
    if @user_shipping_address.save
      redirect_to :controller => 'user_shipping_addresses', :action => 'index' and return
      #redirect_to :controller => 'user_shipping_address', :action => 'index',:id=session[:project_id] and return
    else
      render '/user_shipping_address/new' and return
    end
  end

  def update
    @user_shipping_address=UserShippingAddress.find(params[:id])
    if @user_shipping_address.update_attributes(user_shipping_address_params)
    	redirect_to :controller => 'user_shipping_addresses', :action => 'index' and return
      #redirect_to :controller => 'user_shipping_address', :action => 'index',:id=session[:project_id] and return
    else
      render 'edit'
    end
  end

  def destroy
    @user_shipping_address=UserShippingAddress.find(params[:id])
    @user_shipping_address.destroy   
    redirect_to :controller => 'user_shipping_addresses', :action => 'index' and return
    #redirect_to :controller => 'user_shipping_address', :action => 'index',:id=session[:project_id] and return
  end

  private
  def user_shipping_address_params
    params.require(:user_shipping_address).permit(:address_line_1,:address_line_2,:country,:state,:city,:postal_code)
  end
end
