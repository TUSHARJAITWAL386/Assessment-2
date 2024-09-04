class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index student_enrolled_courses]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now 

      admin_users = User.where(role: :admin)
      UserMailer.registration_report(admin_users.pluck(:email), [@user]).deliver_now
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def student_enrolled_courses
    render json: current_user.role == "admin" ? all_enrolled_student_courses  : current_user.enrolled_courses
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :role, :name, :username, :email, :password, :password_confirmation
    )
  end

  def all_enrolled_student_courses
    all_student_courses = []
    student_users = User.where(role: "student")
    student_users.each do |su|
      all_student_courses << su.enrolled_courses
    end
    all_student_courses.flatten.uniq { |record| record[:id] }
  end
end
