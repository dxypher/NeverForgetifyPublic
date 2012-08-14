class UsersController < ApplicationController
  
  def facebook_api_test
    require 'facebook'
    client = OAuth2::Clients::Facebook.new(FACEBOOK_APP_ID, FACEBOOK_APP_SECRET);
    token = current_user.authentications.where("provider = ?", "facebook").last.token
    token = OAuth2::AccessToken.new(client, token, { :header_format => 'OAuth %s', :param_name => 'access_token'} )
    api_info = token.get('/me/likes').parsed
    @api_info = api_info.to_json
    
  
  end
  
  
end
