# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kanban_roots_session',
  :secret      => '8670ff982e560f36e55ab21a5826386d3d2fce71a65c8825fd5749b540184d6c72e74feaac170f818b7d64fde1552207a4e38929f7d3c81a2b7babfe86b69463'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
