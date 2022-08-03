class InstructorsController < ApplicationRecord
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::InvalidRecord, with: :render_invalid_record

    def index
        instructors=Instructor.all
        render json: instructors
    end

    def show
        instructor=find_instructor
        render json: instructor
    end

    def create
        instructor=Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor=find_instructor
        instructor.destroy
        head :no_content, status: :deleted
    end

    def update
        instructor=find_instructor
        instructor=Instructor.update(instructor_params)
        render json: instructor, status: :accepted

    end

    private

    def find_instructor
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: {error:"Instructor not found"}, status: :not_found
    end

    def render_invalid_record
        render json: {errors:invalid.record.errors}, status: :unprocessable_entity
    end
end