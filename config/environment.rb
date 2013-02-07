# Load the rails application
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
app_keys = File.join(Rails.root, 'config', 'app_keys.rb')
load(app_keys) if File.exists?(app_keys)

# Initialize the rails application
JobBoard::Application.initialize!
