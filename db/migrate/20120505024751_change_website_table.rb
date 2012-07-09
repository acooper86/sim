class ChangeWebsiteTable < ActiveRecord::Migration
  def up
  	change_table :websites do |t|
  		t.rename :code, :theme
  		t.column :title, :string, :limit => 60
  		t.column :motto, :string, :limit => 60
  	end
  end

  def down
  	change_table :websites do |t|
  		t.remove :code
  		t.remove :title
  		t.remove :motto
  	end
  end
end
