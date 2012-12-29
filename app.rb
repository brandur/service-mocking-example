class App < Sinatra::Base
  configure do
    set :raise_errors, true
    set :show_exceptions, false
  end

  before do
    @conn = Excon.new(ENV["NUMBERS_SERVICE_URL"])
  end

  get "/numbers" do
    res = @conn.get(path: "/")
    [res.status, [res.body]]
  end
end
