namespace :never_forgetify do
  desc "Send any pending notifications"
  task :send_notifications => :environment do
    # find all notifications past the current date time with a sent time of nil
    notifications = Notification.where("time <= ?", DateTime.now).where("sent_time IS NULL").find(:all)
    
    puts notifications.inspect
    
    puts "RAN"
    # send the notification via twilio
    client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    notifications.each do |notification|
      
      if notification.send_email == true
        NotificationMailer.notification_email(notification).deliver
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
        notification.sent_time = DateTime.now
        notification.save
      end
    end
    
    # mark that notification as sent at the current time
    
    # save notification
    
    desc "Schedule weekly and daily recurring notifications for each user"
    task :schedule_weekly_daily_notifications => :environment do
       #Schedule table includes all notifications that are recurring
       #find all schedule items that have recurring times within 1 week from DateTime.now
       #append these to notifications table
        #recurring_time += user.notifiction.time + day || week || month
    end
    
    desc "Schedule monthly recurring notifications"
    task do
      
    end
  end
end