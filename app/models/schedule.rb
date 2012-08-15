class Schedule < ActiveRecord::Base
  belongs_to :notificaton
  attr_accessible :sent, :time
  
  def api_attributes
    {
      sent: self.sent,
      time: self.time
    }
  end
end
