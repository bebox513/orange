class AddNameToCorpUser < ActiveRecord::Migration[5.2]
  def change
    add_column :corp_users, :name, :string
  end
end
