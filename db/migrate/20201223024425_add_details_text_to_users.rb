class AddDetailsTextToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :text, :text
  end
end
