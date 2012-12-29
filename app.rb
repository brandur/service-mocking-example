class App < Sinatra::Base
  configure do
    set :raise_errors, true
    set :show_exceptions, false
  end

  before do
    @conn = Excon.new(ENV["NUMBERS_SERVICE_URL"])
  end

  get "/numbers" do
    res = @conn.get(path: "/numbers")
    [res.status, [res.body]]
  end

  get "/numbers/:number" do
    res = @conn.get(path: "/numbers/#{params[:number]}")
    [res.status, [res.body]]
  end

  post "/numbers" do
    res = @conn.post(path: "/numbers", query: { number: params[:number] })
    [res.status, [res.body]]
  end

  delete "/numbers/:number" do
    res = @conn.delete(path: "/numbers/#{params[:number]}")
    [res.status, [res.body]]
  end
end
