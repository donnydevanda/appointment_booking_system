class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.references :doctor, type: :string, null: false, foreign_key: true
      t.references :patient, type: :string, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.timestamps
    end
  end
end
