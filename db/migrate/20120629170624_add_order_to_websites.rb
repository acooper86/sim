class AddOrderToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :order, :string

  end
end
