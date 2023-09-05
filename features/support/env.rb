require 'cucumber/rails'
require 'factory_bot'
require 'warden/test/helpers'

def load_fixture(filename)
  path = Rails.root.join('features', 'support', 'fixtures', filename)
  File.open(path, 'r', &:read)
end


World(Devise::Test::IntegrationHelpers)
World(FactoryBot::Syntax::Methods)
World(Rails.application.routes.url_helpers)

ActionController::Base.allow_rescue = false

