namespace :never_forgetify do
  desc "Send any pending notifications"
  task :send_notifications => :environment do
    # find all notifications past the current date time with a sent time of nil
    schedules = Schedule.where("time <= ?", DateTime.now).where("sent IS NULL").find(:all)
    
    puts "RAN"
    # send the notification via twilio
    client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    schedules.each do |schedule|
      notification = schedule.notification
      
      if notification.send_email == true
        NotificationMailer.notification_email(notification).deliver
        schedule.sent = true
        schedule.save
      end
      
      if notification.send_sms == true  
        phone_number = notification.user.phone_number.gsub(/(^1)*\D/, "");
      
        msg_hash = {:from => TWILIO_NUMBER,
        :to => "+1#{phone_number}",
        :body => notification.body}
      
        puts msg_hash.inspect
      
        client.account.sms.messages.create(
          msg_hash
        )
        schedule.sent = true
        schedule.save
      end
      
      if notification.send_twitter == true
        twitter_handle = notification.user.twitter_handle.gsub(/(^@)/, "")
        Twitter.update("@"+twitter_handle + " " + notification.body)
        schedule.sent = true
        schedule.save 
      end
    end
  end
  desc "Schedule recurring notifications for each user"
  task :schedule_weekly_notifications => :environment do
    Schedule.where("sent IS NOT NULL").destroy_all
    notifications = Notification.where("recurring != 'Not Recurring'").find(:all)
    notifications.each do |notification| 
      case notification.recurring
      when "Every Day"
        r = Recurrence.new(:every => :day, :until => Chronic.parse('next Sunday').to_date)
        r.each do |d|
           rt = DateTime.new(d.year, d.month, d.day, notification.time.hour, notification.time.min, notification.time.sec)
           if rt > DateTime.now
             notification.schedules.create(:time => rt )
           end
         end
      when "Every Week"
        r = Recurrence.new(:every => :week,:on => notification.time.wday, :until => Chronic.parse('next Sunday').to_date)
        r.each do |d|
           rt = DateTime.new(d.year, d.month, d.day, notification.time.hour, notification.time.min, notification.time.sec)
           if rt > DateTime.now
             notification.schedules.create(:time => rt )
           end
         end
      end
    end
  end
  task :schedule_monthly_notifications => :environment do
  notifications = Notification.where(:recurring => 'Every Month').find(:all)
    notifications.each do |notification| 
      r = Recurrence.new(:every => :month, :on => notification.time.day, :until => Chronic.parse('1 day before next month', {:guess => false}).begin.to_date)
      r.each do |d|
         rt = DateTime.new(d.year, d.month, d.day, notification.time.hour, notification.time.min, notification.time.sec)
         if rt > DateTime.now
           notification.schedules.create(:time => rt )
         end
       end
    end
  end
end







