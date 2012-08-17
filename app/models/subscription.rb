class Subscription < ActiveRecord::Base
  belongs_to :user

  attr_accessible(:profile, :status, :cost, :level)
end
