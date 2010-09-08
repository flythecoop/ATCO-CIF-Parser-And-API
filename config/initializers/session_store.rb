# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gmpte_db_session',
  :secret      => '2445593ac65c71d0101f18d2705881257b0efc2c4f1b012a18715acd473c4e098471042f6d7ca7b6d0f3442fce26223c2c4ad9e7c0aa9b2452b67ac8bce1b63c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
