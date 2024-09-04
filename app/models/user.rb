class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  validates :role, presence: true, inclusion: { in: %w[admin teacher student] }
  
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :courses, foreign_key: :teacher_id, dependent: :destroy

  def admin?
    role == 'admin'
  end

  def teacher?
    role == 'teacher'
  end

  def student?
    role == 'student'
  end
end
