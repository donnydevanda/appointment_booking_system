class AppointmentsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      doctor = Doctor.lock.find(appointment_params[:doctor_id])
      @appointment = Appointment.new(appointment_params)
      if @appointment.save!
        render json: @appointment, status: :created
      else
        render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  rescue => e
    render json: { error: "[POST] /appointments failed => #{e.message}" }, status: :internal_server_error
  end

  private

  def appointment_params
    params.permit(:doctor_id, :patient_id, :start_time, :end_time)
  end
end