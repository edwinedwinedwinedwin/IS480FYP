class SystemMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: '[YBCO] - Welcome to Young & Bold Company')
  end

  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: '[YBCO] - Password Reset')
  end

  def accept_proposal(project_proposal)
    @project_proposal = project_proposal
    mail(to: @project_proposal.email, subject: '[YBCO] - Proposal Proposal Result: Approved')
  end

  def reject_proposal(project_proposal)
    @project_proposal = project_proposal
    mail(to: @project_proposal.email, subject: '[YBCO] - Proposal Proposal Result: Rejected')
  end

end
