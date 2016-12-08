# Be sure to restart your server when you modify this file.

#PosterJudging::Application.config.session_store :cookie_store, key: '_PosterJudging_session'
PosterJudging::Application.config.session_store :active_record_store, key: '_PosterJudging_session'
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# PosterJudging::Application.config.session_store :active_record_store
