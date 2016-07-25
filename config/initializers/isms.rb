require 'isms'

ISMS.configure do |config|
  config.username = ENV['ISMS_USERNAME'] || 'username'
  config.password = ENV['ISMS_PASSWORD'] || 'password'
  config.protocol = 'https'
end
