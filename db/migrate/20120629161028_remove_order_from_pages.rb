class RemoveOrderFromPages < ActiveRecord::Migration
  def up
  	change_column :pages, :child, :boolean
  end

  def down
    change_column :pages, :child, :integer
  end
end
