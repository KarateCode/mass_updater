gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
	ENV['BUNDLE_GEMFILE'] = gemfile
	require 'bundler'
	Bundler.setup
	puts "bundler is set up"
rescue Bundler::GemNotFound => e
	STDERR.puts e.message
	STDERR.puts "Try running `bundle install`."
	exit!
end if File.exist?(gemfile)

require 'active_record'
require 'database_cleaner'

DB = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(DB["test"])

RSpec.configure do |config|
	# config.include Capybara::DSL
	
	config.mock_with :rspec

	# Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
	# config.fixture_path = "#{::Rails.root}/spec/fixtures"

	# If you're not using ActiveRecord, or you'd prefer not to run each of your
	# examples within a transaction, remove the following line or assign false
	# instead of true.
	# config.use_transactional_fixtures = false
	
	config.before(:suite) do
		DatabaseCleaner.strategy = :truncation
	end
	
	config.before(:each) do
		DatabaseCleaner.start
	end
	
	config.after(:each) do
		DatabaseCleaner.clean
	end
end