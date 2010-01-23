# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_famlog_session',
  :secret      => 'a2a704ae8bafd45d7ae875afcb5e8026b2e685732aaef5768dc0129edf825aa4e11fec4ac122c5ffb1c4012a443858ddf0fd2b1791cda72b623e9955f0d3856d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
