class UsersController < ApplicationController
  
  def facebook_api_test
    require 'facebook'
    client = OAuth2::Clients::Facebook.new(FACEBOOK_APP_ID, FACEBOOK_APP_SECRET);
    token = current_user.authentications.where("provider = ?", "facebook").last.token
    token = OAuth2::AccessToken.new(client, token, { :header_format => 'OAuth %s', :param_name => 'access_token'} )
    api_info = token.get('/me/likes').parsed
    @api_info = api_info.to_json
    
  
  end
  
  def show
    @user = User.find(current_user)
  end
  
  def edit
    @user = User.find(current_user)
  end
  
  def update
    user = User.find(params[:id])
    user.update_attributes(params[:user])
    redirect_to root_path
  end
  
  def reset_password_form
    @user = User.find(params[:id])
  end
  
  def reset_password
    puts params[:user][:password]
    user = User.find(params[:id]).reset_password!(params[:user][:password], params[:user][:password_confirmation])
    redirect_to root_path
  end
  
end
