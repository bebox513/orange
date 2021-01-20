class CreateCareDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :care_diaries do |t|
      t.text :notes
      t.float :temperature
      t.date :date
      t.integer :meal_intake
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
