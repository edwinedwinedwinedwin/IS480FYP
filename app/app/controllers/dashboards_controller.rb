class DashboardsController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
  	@session=session[:user_id]
  end
end
