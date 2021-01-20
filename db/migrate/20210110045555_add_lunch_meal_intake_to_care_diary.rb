class AddLunchMealIntakeToCareDiary < ActiveRecord::Migration[5.2]
  def change
    add_column :care_diaries, :lunch_meal_intake, :integer
  end
end
