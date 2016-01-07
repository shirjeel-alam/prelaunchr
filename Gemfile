source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '3.2.22'
gem 'mysql2', '0.3.20'
gem 'activeadmin', '0.6.6'
gem 'haml-rails'
gem 'puma'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'localtunnel'
end

group :development, :test do
  gem 'spring'
  gem 'annotate'
  gem 'pry-rails'
  gem 'letter_opener'
  gem 'test-unit', '~> 3.0'
end

gem 'rails_12factor', group: :production
