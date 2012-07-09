class RemoveOrderFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :order
  	change_column :pages, :child, :boolean
  end

  def down
    add_column :pages, :order, :integer
    change_column :pages, :child, :integer
  end
end
