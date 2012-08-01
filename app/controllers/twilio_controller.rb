class TwilioController < NotificationController
  def create
    from = params[:from]
    body = params[:body]
    message_parts = body.split("say")
    time = message_parts[0]
    message = message_parts.length > 1 ? message_parts[1] : "You set a reminder."
    sender = User.find_by_phone_number(from) rescue nil
    
    if sender.present?
      @notification = Notification.new
      @notificaition.user = sender
      @notification.natural_time = time
      @notification.body = message
      @notification.save
    else
      
    end
    
  end
end
