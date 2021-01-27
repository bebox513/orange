class RenameInsuredNumberColumnToCareRecipients < ActiveRecord::Migration[5.2]
  def change
    rename_column :care_recipients, :insured_number, :care_insurance_number
  end
end
