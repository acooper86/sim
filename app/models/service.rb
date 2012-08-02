class Service < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible(:main, :name, :description, :available, :prerequisite)
  
  serialize :available, Hash
  
  has_many :prerequisite_relationship,
           :foreign_key   =>  :service_id,
           :dependent     =>  :destroy

  has_many :prerequisites,
           :through => :prerequisite_relationship,
           :source  => :main
           
  def create_available_hash(available)
    i = 0
    available_hash = {}
    
    available["time"].each do |t|
      available_hash.merge(t => available["cost"][i])
      i = i + 1
    end
    
    return available_hash
  end
end
