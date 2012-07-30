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
    
    # mark that notification as sent at the current time
    
    # save notification
  end
end