source 'https://rubygems.org'

gem 'rails', '5.0.0'
ruby '2.3.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'	#fewer errors when moving to production
gem 'rqrcode_png'
gem 'figaro'
gem 'delayed_job_active_record'
gem "daemons"



# for Heroku deployment - as described in Ap A of ELLS book
group :development, :test do
	gem 'rspec-rails'
 	gem 'byebug'
	gem 'jasmine-rails'
	gem 'railroady'
end

group :test do
	gem 'simplecov', :require => false
	gem 'cucumber-rails', :require => false
	gem 'cucumber-rails-training-wheels'
	gem 'database_cleaner'
	gem 'autotest-rails'
	gem 'factory_girl_rails'
	gem 'metric_fu'
	gem "capybara"
	gem 'email_spec'
  gem "launchy"
	gem 'test-unit'
  gem 'rails-controller-testing'
	gem 'capybara-webkit'
  gem 'headless'
end

group :production do
  gem 'rails_12factor'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

gem 'activerecord-session_store'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
# use Haml for templates
gem 'haml'