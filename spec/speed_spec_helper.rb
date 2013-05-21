require 'active_support/all'
require 'active_model'
require 'rubygems'
require 'pry'
require "speed_schema"
require "speed_associations"
require "speed_scopes"
require "speed_dirty"
require "speed_model"
require "speed_database"
require "speed_array"


Dir[("app/services/*.rb")].each do |f| 
  file = f.gsub(".rb", "")
  require "./#{file}"
end

# require 'active_record'
# require 'devise'
# require 'devise/orm/active_record'



Dir[("app/models/*.rb")].each do |f| 
  file = f.gsub(".rb", "")
  require "./#{file}"
end

Dir[("app/commands/*.rb")].each do |f| 
  file = f.gsub(".rb", "")
  require "./#{file}"
end

# require 'factory_girl'
# require 'factories'

Db = SpeedDatabase.new

Dir[("spec/support/**/*.rb")].each do |f| 
  file = f.gsub(".rb", "")
  require "./#{file}"
end

RSpec.configure do |config|
  config.before(:each) do
    Db.clear
  end
#   config.include LoginHelpers, :type => :request
#   config.include ContestHelpers
#   config.include LeagueHelpers
#   config.include CreditCardHelpers
#   config.include ScenarioHelpers
#   config.include OmniauthHelpers, :type => :request
#   config.include WithdrawalRequestHelpers, :type => :request
#   config.include BonusCodeHelpers
#   config.include SurvivorContestHelpers
end