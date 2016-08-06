class SysMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: '[YBCO] Welcome to Young & Bold Company')
  end

 def reset_password_email(user)
   @user = user
   mail(to: @user.email, subject: '[YBCO] Password Reset')
 end

 def accept_proposal_email(project_proposal)
   @project_proposal = project_proposal
   mail(to: @project_proposal.email, subject: '[YBCO] Proposal Proposal Result: Approved')
 end

 def reject_proposal_email(project_proposal)
   @project_proposal = project_proposal
   mail(to: @project_proposal.email, subject: '[YBCO] Proposal Proposal Result: Rejected')
 end
end
