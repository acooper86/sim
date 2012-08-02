class CreatePrerequisiteRelationships < ActiveRecord::Migration
  def change
    create_table :prerequisite_relationships do |t|
      t.references :main
      t.references :service

      t.timestamps
    end
    add_index :prerequisite_relationships, :main_id
    add_index :prerequisite_relationships, :service_id
  end
end
