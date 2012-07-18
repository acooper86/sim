class AddTypeToImage < ActiveRecord::Migration
  def change
    add_column :images, :profile, :boolean
    add_column :images, :logo, :boolean

  end
end
