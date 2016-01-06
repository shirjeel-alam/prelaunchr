# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Prelaunchr::Application.config.secret_token = ENV["RAILS_SECRET"] || 'bbbfa2c4031396b0ba2e2463ba3a8f7389a5ac828f2328505b0067db0f30671c4ee647201a141984d2d9beddf2409e0d847e7c2c6b3c42436fb2791110ae5388'