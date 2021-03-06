ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/email/rspec'


Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL,           type: :feature
  config.include Capybara::RSpecMatchers, type: :feature

  config.use_transactional_fixtures                 = false
  config.infer_base_class_for_anonymous_controllers = true

  config.order = "random"

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def last_email
  ActionMailer::Base.deliveries.last
end

def login_with(resource)
  namespace = resource.class.to_s.downcase

  visit "/#{namespace.pluralize}/sign_in"

  fill_in "#{namespace}[email]",    with: resource.email
  fill_in "#{namespace}[password]", with: "123123123"

  click_button 'Sign in'
end
