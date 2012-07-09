class Changetable < ActiveRecord::Migration
  def up
 	change_table :users do |t|
      t.rename :name, :first_name
      t.column :last_name, :string, :limit=>60
      t.column :address_l1, :string, :limit=>60
      t.column :address_l2, :string, :limit=>60
      t.column :city, :string, :limit=>60
      t.column :state, :string, :limit=>60
      t.column :zip, :string, :limit=>12
      t.column :telephone, :string, :limit=>12
      t.column :business, :string, :limit=>60
    end
  end

  def down
  	change_table :users do |t|
      t.rename :first_name, :name
      t.remove :last_name, :string, :limit=>60
      t.remove :address_l1, :string, :limit=>60
      t.remove :address_l2, :string, :limit=>60
      t.remove :city, :string, :limit=>60
      t.remove :state, :string, :limit=>60
      t.remove :zip, :string, :limit=>12
      t.remove :telephone, :string, :limit=>12
      t.remove :business, :string, :limit=>60
    end
  end
end
