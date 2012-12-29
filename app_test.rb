require "bundler/setup"
Bundler.require

require "minitest/autorun"
require "rack/test"
require "webmock/minitest"

require_relative "app"
require_relative "numbers_service"

set :run, false

ENV["NUMBERS_SERVICE_URL"] = "https://my-service.example.com"

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    App
  end

  def setup
  # stub_request(:any, /#{ENV["SERVICE_URL"]}\/.*/).to_rack(Service)
    stub_numbers_service
  end

  def test_service
    get "/numbers"
    assert_equal 200, last_response.status
  end

  def test_service_error
  # stub_request(:any, /#{ENV["SERVICE_URL"]}\/.*/).to_rack(Sinatra.new(Service) {
  #   get "/numbers" do
  #     422
  #   end
  # })
    stub_numbers_service do
      get "/numbers" do
        422
      end
    end
    get "/numbers"
    assert_equal 422, last_response.status
  end

  private

  def stub_numbers_service(&block)
    stub = block ? Sinatra.new(NumbersService, &block) : NumbersService
    stub_request(:any, /#{ENV["NUMBERS_SERVICE_URL"]}\/.*/).to_rack(stub)
  end
end
