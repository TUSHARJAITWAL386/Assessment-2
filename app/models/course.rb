class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :enrollments, dependent: :destroy
  has_many :students,through: :enrollments, source: :student

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :teacher, presence: true  
end


