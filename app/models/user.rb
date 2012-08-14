class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone_number, :profile_pic, :username, :facebook, :time_zone, :first_name, :last_name
  has_many :authentications
  before_validation do
    self.phone_number = self.phone_number.gsub(/(^1)*\D/, "") if self.phone_number.present?
  end
  
  has_many :notifications
  
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
end
