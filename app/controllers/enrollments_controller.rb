class EnrollmentsController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource

  def index
    @enrollments = Enrollment.all
    render json: @enrollments
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      render json: @enrollment, status: :created
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end


  def update
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.update(enrollment_params)
      render json: @enrollment
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.destroy
      head :no_content
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:student_id, :course_id, :grade)
  end
end

