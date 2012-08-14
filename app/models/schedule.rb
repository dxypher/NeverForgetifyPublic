class Schedule < ActiveRecord::Base
  belongs_to :notificaton
  attr_accessible :sent, :time
end
