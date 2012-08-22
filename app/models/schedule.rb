class Schedule < ActiveRecord::Base
  belongs_to :notificaton
  attr_accessible :sent, :time
  
  validates :time, :uniqueness => { :scope => :notification_id,
      :message => "Only one schedule time per notification" }
  
  def api_attributes
    {
      sent: self.sent,
      time: self.time
    }
  end
end
