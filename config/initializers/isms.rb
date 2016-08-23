require 'isms'

ISMS.configure do |config|
  config.username = Settings.isms.username
  config.password = Settings.isms.password
  config.protocol = 'https'
end
