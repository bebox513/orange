class AddNameToCareDiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :care_diaries, :name, :string
  end
end
