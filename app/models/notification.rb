class Notification < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :time, :natural_time, :recurring
  
  before_validation do
    self.time = Chronic.parse(self.natural_time, :context => :future)
  end
  
  validates :time, :presence => true
  
end
