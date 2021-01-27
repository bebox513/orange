class RemoveInsurerNumberFromCareRecipients < ActiveRecord::Migration[5.2]
  def change
    remove_column :care_recipients, :insurer_number, :integer
  end
end
