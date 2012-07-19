class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.string :address_l1
      t.string :address_l2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.string :secondary_email
      t.string :business
      t.date :birth_date
      t.string :ctype
      t.boolean :email_list
      t.datetime :opt_in
      t.string :created_from

      t.timestamps
    end
    add_index :contacts, :user_id
  end
end
