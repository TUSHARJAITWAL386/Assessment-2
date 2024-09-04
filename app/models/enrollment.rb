class Enrollment < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :course

  validates :student, presence: true
  validates :course, presence: true
  validates :grade, presence: true
  validates :student_id, uniqueness: { scope: :course_id }
  
end
