class Notification < ActiveRecord::Base
  belongs_to :user
  has_many :schedules, dependent: :destroy
  attr_accessible :body, :time, :natural_time, :recurring
  
  before_validation do
    self.time = Chronic.parse(self.natural_time, :context => :future)
  end

  validates :time, :presence => true
  
  after_save do
    case self.recurring
    when "Not Recurring"
      self.schedules.create(time: self.time)
    when "Every Day"
      r = Recurrence.new(:every => :day, :until => Chronic.parse('next Sunday').to_date)
      r.each do |d|
        rt = DateTime.new(d.year, d.month, d.day, self.time.hour, self.time.min, self.time.sec)
        if rt > DateTime.now
          self.schedules.create(:time => rt )
        end
      end
    when "Every Week"
      if self.time > DateTime.now
        self.schedules.create(time: self.time)
      end
    when "Every Month"
      if self.time > DateTime.now
        self.schedules.create(time: self.time)
      end
    end
  end
  def api_attributes
    { id: self.id,
      body: self.body,
      time: self.time,
      recurring: self.recurring
    }
  end
  def full_api_attributes
    { id: self.id,
      body: self.body,
      time: self.time,
      recurring: self.recurring,
      schedules: self.schedules.collect{|s| s.api_attributes }
    }
  end
  
end
