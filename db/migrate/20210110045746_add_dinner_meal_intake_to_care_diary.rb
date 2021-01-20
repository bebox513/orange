class AddDinnerMealIntakeToCareDiary < ActiveRecord::Migration[5.2]
  def change
    add_column :care_diaries, :dinner_meal_intake, :integer
  end
end
