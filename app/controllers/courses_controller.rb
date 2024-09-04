class CoursesController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource

  def index
    @courses = Course.accessible_by(current_ability)
    render json: @courses
  end

  def create
    @course = Course.new(course_params)
    @course.teacher = current_user if current_user.teacher?

    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def show
    @course = Course.find(params[:id])
    authorize! :read, @course
    render json: @course
  end

  def update
    @course = Course.find(params[:id])
    authorize! :update, @course

    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(params[:id])
    authorize! :destroy, @course
    
    if @course.destroy
      head :no_content
    else
      render json: { error: 'Failed to delete course' }, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :teacher_id)
  end
end
