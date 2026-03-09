class CreatePatients < ActiveRecord::Migration[8.1]
  def change
    create_table :patients, id: :string do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
