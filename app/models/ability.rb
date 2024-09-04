# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.teacher?
      can :manage, Course, teacher_id: user.id
      can :read, Enrollment, course: { teacher_id: user.id }
      can :update, Enrollment
    elsif user.student?
      can :read, Enrollment, student_id: user.id
      can :read, Course, enrollments: { student_id: user.id }
    else
      can :read, :home # Allow guests to access a home or landing page
    end
  end
end
