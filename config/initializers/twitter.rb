require 'twitter'

twitter_config = YAML.load(File.read(Rails.root.join('config', 'twitter.yml')))[Rails.env]

Twitter.configure do |config|
  config.consumer_key = 'as9dttvX7AySHhh6QWDRg'
  config.consumer_secret = 'qjXRiKIcNnXFXUKTFeALVV4iPkNQfa6ZbIEA8dkANQ'
  config.oauth_token = twitter_config['oauth_token']
  config.oauth_token_secret = twitter_config['oauth_token_secret']
end