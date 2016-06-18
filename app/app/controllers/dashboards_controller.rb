class DashboardsController < ApplicationController
  def index
  	@session=session[:user_id]
  	if@session.to_s.empty? 
  		redirect_to :controller => 'sessions', :action => 'new' and return
  	end
  end
end
