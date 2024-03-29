class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :upassword, :remember_me, :phone_number,
                  :profile_pic, :username, :facebook, :time_zone, :first_name, :last_name, :login, :twitter_handle
  attr_accessor :login
  has_many :authentications
  before_validation do
    self.phone_number = self.phone_number.to_s.gsub(/(^1)*\D/, "") if self.phone_number.present?
    # self.phone_number = self.phone_number if self.phone_number.present?
  end
  
  has_many :notifications
  
  
  
  after_update do
    if self.twitter_handle == ""
      self.twitter_handle = nil
      self.save
    elsif self.phone_number == ""
      self.phone_number = nil
      self.save
    elsif self.email == ""
      self.email = nil
      self.save
    end
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["phone_number = :pvalue OR lower(email) = :evalue", { :pvalue => login.gsub("+1", "").gsub(/(^1)*\D/, ""), :evalue => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  alias :old_send_reset_password_instructions :send_reset_password_instructions 
  
  def send_reset_password_instructions
    
    if self.email.include?("@neverforgetify.com")
      new_password = Devise.friendly_token[0,6];
      self.reset_password!(new_password,new_password);
      client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
      phone_number = self.phone_number.gsub(/(^1)*\D/, "");
      
      msg_hash = {:from => TWILIO_NUMBER,
      :to => "+1#{phone_number}",
      :body => "Your new temporary password is: #{new_password}"}
      
      puts msg_hash.inspect
      
      client.account.sms.messages.create(
        msg_hash
      )
      
      
    else
      self.old_send_reset_password_instructions
    end  
  end
  
  def self.find_or_create_for_oauth(access_token, signed_in_resource=nil)
       
     data = access_token
     
    
     authentication = Authentication.where(:uid => access_token.extra.raw_info.id, :provider => access_token.provider).first
     rev_user = authentication.nil? ? nil : authentication.user
     user = signed_in_resource || rev_user || User.where("email = ? AND email IS NOT NULL", data.info.email).first
     if !user.nil?
       #user exists with email create an authentication and log the user in
       if !rev_user
         user.authentications.create!(:uid => access_token.uid, :provider => access_token.provider, :token => access_token.credentials.token, :token_secret => access_token.credentials.secret)
         return user
       else
         return rev_user
       end
     else
       user = User.create!(:email => data.info.email, :facebook => data.info.nickname, :first_name => data.info.first_name, :profile_pic => data.info.image, :time_zone => access_token.extra.raw_info.timezone.to_i, :last_name => data.info.last_name, :username => data.info.nickname, :password => Devise.friendly_token[0,20]) 
       user.authentications.create!(:uid => access_token.extra.raw_info.id, :provider => access_token.provider, :token => access_token.credentials.token)
       user.save()
       return user
     end
   end
   
   def self.create_temp_login from
     email = "#{from}@neverforgetify.com"
     upassword = Devise.friendly_token[0,6]
     {:user => User.create(email: email, phone_number: from, password: upassword), :temppassword => upassword}
   end
   
end
