class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :token, :token_secret, :uid, :provider
end
