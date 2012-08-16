class NotificationMailer < ActionMailer::Base
  default from: "admin@neverforgetify.com"
  
  def notification_email(notification)
    @notification = notification
    @user = notification.user
    mail(to: notification.user.email, subject: "Your Notification")
    
  end
end
