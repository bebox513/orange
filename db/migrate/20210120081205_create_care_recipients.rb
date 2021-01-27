class CreateCareRecipients < ActiveRecord::Migration[5.2]
  def change
    create_table :care_recipients do |t|
      t.string :name
      t.integer :sex
      t.date :birthday
      t.integer :age
      t.string :facility_in_charge
      t.string :manager_in_charge
      t.integer :insured_number
      t.integer :insurer_number
      t.integer :degree_care_required
      t.integer :dementia
      t.text :notes
      t.integer :user_id

      t.timestamps
    end
  end
end
