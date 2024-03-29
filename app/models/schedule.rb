class Schedule < ActiveRecord::Base
  belongs_to :notification
  attr_accessible :sent, :time, :sent_time
  
  validates :time, :uniqueness => { :scope => :notification_id,
      :message => "Only one schedule time per notification" }
  
  def api_attributes
    {
      sent: self.sent,
      time: self.time
    }
  end
end
