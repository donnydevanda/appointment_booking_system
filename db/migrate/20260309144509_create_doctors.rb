class CreateDoctors < ActiveRecord::Migration[8.1]
  def change
    create_table :doctors, id: :string do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
