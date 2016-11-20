class SysMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: '[YBCO] Welcome to Young & Bold Company')
  end

 def reset_password_email(user,new_password)
   @user = user
   @new_password=new_password
   mail(to: @user.email, subject: '[YBCO] Password Reset')
 end

 def new_proposal_email(project_proposal)
   @project_proposal = project_proposal
   mail(to: @project_proposal.email, subject: '[YBCO] Project Proposal Submission')
 end

 def accept_proposal_email(project_proposal)
   @project_proposal = project_proposal
   mail(to: @project_proposal.email, subject: '[YBCO] Project Proposal Result: Approved')
 end

 def accept_new_proposal_email(password,project_proposal)
   @project_proposal = project_proposal
   @new_password=password
   mail(to: @project_proposal.email, subject: '[YBCO] Project Proposal Approved & Account Created')
 end

 def reject_proposal_email(project_proposal)
   @project_proposal = project_proposal
   mail(to: @project_proposal.email, subject: '[YBCO] Project Proposal Result: Rejected')
 end

  def accept_request_go_live(project)
    @project = project
    @creator_user = User.find(@project.user_id)
    mail(to: @creator_user.email, subject: '[YBCO] Project Live Result: Approved')
  end

  def reject_request_go_live(project)
    @project = project
    @creator_user = User.find(@project.user_id)
    mail(to: @creator_user.email, subject: '[YBCO] Project Live Result: Rejected')
  end

end
