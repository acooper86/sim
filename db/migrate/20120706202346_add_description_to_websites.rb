class AddDescriptionToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :description, :string

    add_column :websites, :keywords, :string

  end
end
