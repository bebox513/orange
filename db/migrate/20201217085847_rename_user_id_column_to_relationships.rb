class RenameUserIdColumnToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_column :relationships, :user_id, :following_id
  end
end
