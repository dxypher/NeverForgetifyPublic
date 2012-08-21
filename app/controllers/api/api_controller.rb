class Api::ApiController < ApplicationController
  
  
  prepend_before_filter :api_authentication
  
  def api_authentication



      if request.headers["AuthType"].present?
        type = request.headers["AuthType"].downcase
        if type == 'facebook'
          require 'facebook'

          token = request.headers["AccessToken"]
          atoken = token

          authentication = Authentication.find_by_token_and_provider(token, type) rescue nil



          if authentication.present? && authentication.user.present?
            user = authentication.user
          else        
            puts "LOOKING UP AT FB!!!!!!!!!!!!!!!!!!!!!"
            client = OAuth2::Clients::Facebook.new('', '')
            token = OAuth2::AccessToken.new(client, token, { :header_format => 'OAuth %s',
            :param_name => 'access_token'} )



            raw_info = token.get('/me').parsed

            puts raw_info.to_json

            data = prune!({
              'provider' => "facebook",
              'uid' => raw_info["id"],
              'nickname' => raw_info['username'],
              'email' => raw_info['email'],
              'name' => raw_info['name'],
              'first_name' => raw_info['first_name'],
              'last_name' => raw_info['last_name'],
              'image' => "http://graph.facebook.com/#{raw_info["id"]}/picture?type=square",
              'description' => raw_info['bio'],
              'urls' => {
                'Facebook' => raw_info['link'],
                'Website' => raw_info['website']
              },
              'location' => (raw_info['location'] || {})['name'],
              'verified' => raw_info['verified'],
              'extra' => {
                'raw_info' => raw_info,
              },
              'credentials' => {
                'token' => atoken
              }

            });

            hash = OmniAuth::AuthHash.new data


            puts hash.inspect

            user = User.find_or_create_for_oauth(hash, nil)
          end

          sign_in(:user, user) if user.present?


        end
      end
    end  



    private 

        def prune!(hash)
          hash.delete_if do |_, value|
            prune!(value) if value.is_a?(Hash)
            value.nil? || (value.respond_to?(:empty?) && value.empty?)
          end
        end
end
