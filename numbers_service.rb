class NumbersService < Sinatra::Base
  configure do
    set :raise_errors, true
    set :show_exceptions, false
  end

  get "/numbers" do
    numbers = [4, 8, 15, 16, 23, 42].map { |n| { number: n } }
    [200, [MultiJson.encode(numbers)]]
  end

  get "/numbers/:number" do
    [200, [MultiJson.encode(number: params[:number])]]
  end

  post "/numbers" do
    [201, [MultiJson.encode(number: params[:number])]]
  end

  delete "/numbers/:number" do
    [200, [MultiJson.encode(number: params[:number])]]
  end
end
