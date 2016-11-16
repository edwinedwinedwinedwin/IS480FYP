class ProjectMilestonesController < ApplicationController
  before_filter :logged_in, :authorize_user
  def index
    @projectMilestones = ProjectMilestone.all

  end

  def new
    @projectMilestone= ProjectMilestone.new
    @projectMilestone.project_id = params[:project_id]
  end

  def edit
    @projectMilestone  = ProjectMilestone.find(params[:id])
  end

  def create
    @projectMilestone = ProjectMilestone.new(project_milestones_params)
    @projectMilestone.amount_raised = 0
    @projectMilestones = ProjectMilestone.order('start_date ASC').where(:project_id => @projectMilestone.project_id)

    startA = @projectMilestone.start_date
    endA = @projectMilestone.end_date

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
      if @projectMilestone.save
        redirect_to showProject_path(:id => @projectMilestone.project_id) and return
      else
        redirect_to showProject_path(:id => @projectMilestone.project_id) and return
      end
    else #overlapping
      #error
      redirect_to showProject_path(:id => @projectMilestone.project_id) and return
    end

  end

  def update
    @projectMilestone = ProjectMilestone.find(params[:id])
    if @projectMilestone.update(project_milestones_params)
      redirect_to showProject_path(:id => @projectMilestone.project_id) and return
    else
      render 'edit'
    end
  end

  def destroy
    @projectMilestone=ProjectMilestone.find(params[:id])
    @projectMilestone.destroy

    redirect_to :controller => 'project_milestones', :action => 'index' and return
  end

  private
  def project_milestones_params
    params.require(:project_milestone).permit(:name, :start_date, :end_date, :target_amount, :amount_raised, :project_id, :project_status_id)
  end
end