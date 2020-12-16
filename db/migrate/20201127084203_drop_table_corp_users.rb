class DropTableCorpUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :corp_users
  end
end
