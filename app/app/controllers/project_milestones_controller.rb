class ProjectMilestonesController < ApplicationController
	before_filter :logged_in, :authorize_user
	def index
		@projectMilestones = ProjectMilestone.all

	end

	def new
		@project_milestone = ProjectMilestone.new
		@project_milestone.project_id = params[:project_id]
	end

	def edit
		@project_milestone = ProjectMilestone.find(params[:id])
	end

	def create
		@project_milestone = ProjectMilestone.new(project_milestones_params)
    @projectMilestones = ProjectMilestone.order('start_date ASC').where(:project_id => @project_milestone.project_id)

    startA = @project_milestone.start_date
    endA = @project_milestone.end_date


    i = 0
    if @projectMilestones.nil?
      if startA > Date.today && endA > Date.today

      else
        i = 1 + i
      end
    else
    # Convent to last day


    @projectMilestones.each do |all|
      startB = all.start_date
      endB = all.end_date

      #before
        if (startA < endB)  &&  (endA > startB)
            i = 1+i
        end
      end
    end

    if i == 0 #outside the time frame
      if @project_milestone.save
        redirect_to showProject_path(:id => @project_milestone.project_id) and return
      else
        redirect_to showProject_path(:id => @project_milestone.project_id) and return
      end
    else #overlapping
      #error
      redirect_to showProject_path(:id => @project_milestone.project_id) and return
    end

	end

	def update
		@project_milestone = ProjectMilestone.find(params[:id])
		if @project_milestone.update(project_milestones_params)
			redirect_to showProject_path(:id => @project_milestone.project_id) and return
		else
			render 'edit'
		end
	end

	def destroy
		@project_milestone=ProjectMilestone.find(params[:id])
		@project_milestone.destroy

		redirect_to :controller => 'project_milestones', :action => 'index' and return
	end

	private
	def project_milestones_params
		params.require(:project_milestone).permit(:name, :start_date, :end_date, :amount_raised, :target_amount, :project_id, :project_status_id)
	end
end