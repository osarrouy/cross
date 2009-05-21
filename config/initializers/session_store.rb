# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cross_session',
  :secret      => 'bbd437f75baa831ffbe53fd6ad1a299a8d5af1ea73fbf5c6ceb6fef4af14d93b5977039360fb42837a09e7cac57884d461a407fd4381fe4e378776452d788f23'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
