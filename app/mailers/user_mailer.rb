class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(
      from: 'no-reply@your-domain.com',
      to: @user.email,
      subject: 'Welcome to My API Based Application',
      content_type: 'text/html'
    )
  end

  def registration_report(admin_email, users)
    @users = users
    mail(to: admin_email, subject: 'New User Registrations Report')
  end

  def weekly_progress_report(admin_email, progress_data)
    @progress_data = progress_data
    mail(to: admin_email, subject: 'Weekly Student Progress Report')
  end
end


