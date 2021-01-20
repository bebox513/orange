class RenameMealIntakeColumnToCareDiaries < ActiveRecord::Migration[5.2]
  def change
    rename_column :care_diaries, :meal_intake, :breakfast_meal_intake
  end
end
