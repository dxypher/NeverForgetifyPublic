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
    
    
    respond_to do |format|
      format.xml {
      if sender.present?
        @notification = Notification.new
        @notification.user = sender
        @notification.natural_time = time
        @notification.body = message
        if @notification.save
          response = Twilio::TwiML::Response.new do |r|
            r.Sms "Your notification has been set."
          end
          render :xml => response.text
        else
          response = Twilio::TwiML::Response.new do |r|
            x = @notification.errors.messages
            r.Sms "#{ x }"
          end
          render :xml => response.text
        end
      else
        new_user = create_temp_login from
        response = Twilio::TwiML::Response.new do |r|
          r.Sms "You're notification has been set, login with your phone number and use #{new_user.upassword} as your password."
        end
        render :xml => response.text
      end
      } 
    end
  end
end
