class StudentsController < ApplicationRecord
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::InvalidRecord, with: :render_invalid_record
    def index
        students=Student.all
        render json: students
    end

    def show
        student=student_by_id
        render json: student

    end

    def create
        student=Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student=student_by_id
        student.update(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student=student_by_id
        student.destroy
        head :no_content, status: :deleted
    end

    private
    def student_params
        params.permit(:name,:age,:major,:instructor_id)
    end

    def student_by_id
        Student.find(params[:id])
    end

    def render_not_found_response
        render json: {error:"Student not found"},status: :not_found
    end

    def render_invalid_record
        render json:{errors:invalid.record.errors}, status: :unprocessable_entity
    end
end