class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :doctor_id, :patient_id, :start_time, :end_time, presence: true

  validate :end_time_after_start_time
  validate :no_overlapping

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def no_overlapping
    return if doctor.nil? || start_time.blank? || end_time.blank?

    overlap = Appointment.where(doctor_id: doctor_id)
                         .where.not(id: id)
                         .where("start_time < ? AND end_time > ?", end_time, start_time)
                         .exists?

    errors.add(:base, "The doctor is already booked by other patients.") if overlap
  end
end