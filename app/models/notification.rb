class Notification < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :user
  has_many :schedules, dependent: :destroy
  attr_accessible :body, :time, :natural_time, :recurring, :send_email, :send_sms, :send_twitter
  
  before_validation do
    self.time = Chronic.parse(self.natural_time, :context => :future)
  end

  validates :time, :presence => true
  validate :where_to_send_notification
  
  def where_to_send_notification
    if send_twitter == true && user.twitter_handle.nil?
      errors.add(:send_twitter, "Must add Twitter handle to your profile.")
    elsif send_email == true && user.email.nil?
      errors.add(:email, "Must add email to your profile.")
    elsif send_sms == true && user.phone_number.nil?
      errors.add(:phone_number, "Must add phone number to your profile.")
    end
  end
  
  
  
  after_create do
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
