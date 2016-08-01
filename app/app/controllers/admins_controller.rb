class AdminsController < ApplicationController
  before_filter :logged_in,:authorize_admin, only: [:index,:show]
  def index
  	@session=session[:user_id]
  end

  def new
   @user = User.new  	
  end
end
