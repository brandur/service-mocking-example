require "bundler/setup"
Bundler.require

require "minitest/autorun"
require "rack/test"
require "webmock/minitest"

require_relative "app"
require_relative "numbers_service_stub"

set :run, false

ENV["NUMBERS_SERVICE_URL"] = "https://my-service.example.com"

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    App
  end

  def setup
    stub_numbers_service
  end

  def test_numbers
    get "/numbers"
    assert_equal 200, last_response.status
  end

  def test_numbers_error
    stub_numbers_service do
      get "/" do
        422
      end
    end
    get "/numbers"
    assert_equal 422, last_response.status
  end

  private

  def stub_numbers_service(&block)
    stub = block ? Sinatra.new(NumbersServiceStub, &block) : NumbersServiceStub
    stub_request(:any, /^#{ENV["NUMBERS_SERVICE_URL"]}\/.*$/).to_rack(stub)
  end
end
