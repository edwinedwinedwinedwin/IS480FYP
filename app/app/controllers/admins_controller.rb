class AdminsController < ApplicationController
  before_filter :logged_in
  def index
  	@session=session[:user_id]
  end
end
