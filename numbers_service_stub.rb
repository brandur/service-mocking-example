class NumbersServiceStub < Sinatra::Base
  configure do
    set :raise_errors, true
    set :show_exceptions, false
  end

  get "/numbers" do
    [200, [MultiJson.encode([4, 8, 15, 16, 23, 42])]]
  end
end
