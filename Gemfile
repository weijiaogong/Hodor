source 'https://rubygems.org'

gem 'rails', '>= 3.2.15'
ruby '2.3.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'	#fewer errors when moving to production

# for Heroku deployment - as described in Ap A of ELLS book
group :development, :test do
	gem 'rspec-rails', '>= 2.14'
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
	gem 'test-unit'
end

group :production do
  gem 'rails_12factor'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# use Haml for templates
gem 'haml'
