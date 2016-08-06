# Preview all emails at http://localhost:3000/rails/mailers/sys_mailer
class SysMailerPreview < ActionMailer::Preview

  def welcome_email_preview
    SysMailer.welcome_email(User.first)
  end
end
