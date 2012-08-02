class PrerequisiteRelationship < ActiveRecord::Base
  belongs_to :main, :class_name => "Service"
  belongs_to :service
end
