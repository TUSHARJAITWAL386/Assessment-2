class WeeklyProgressReportJob < ApplicationJob
  queue_as :default

  def perform
    admin_emails = User.where(role: 'admin').pluck(:email)
    progress_data = generate_progress_report
    UserMailer.weekly_progress_report(admin_emails, progress_data).deliver_now
  end

  private

  def generate_progress_report
    reports = []
    students = User.where(role: "student")
    students.each do |user|
      reports << {
        name: user.name,
        email: user.email,
        enrolled_courses: user.enrolled_courses,
        enrollments: user.enrollments
      }
    end
    reports
  end
end

