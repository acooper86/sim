class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :string

  end
end
