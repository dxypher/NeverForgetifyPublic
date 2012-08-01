class TwilioController < ActionController::Base
  def create
    from = params[:From]
    from.gsub!("+1", "");
    body = params[:Body]
    message_parts = body.split("say")
    time = message_parts[0]
    
    puts time.inspect
    
    message = message_parts.length > 1 ? message_parts[1] : "You set a reminder."
    sender = User.find_by_phone_number(from) rescue nil
    
    if sender.present?
      @notification = Notification.new
      @notification.user = sender
      @notification.natural_time = time
      @notification.body = message
      @notification.save
    else
      
    end
    
  end
end
