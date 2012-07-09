class ChangeTypeToPType < ActiveRecord::Migration
  def up
  	rename_column :pages, :type, :ptype
  end

  def down
  	rename_column :pages, :ptype, :type
  end
end
