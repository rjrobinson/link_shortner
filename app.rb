require 'sinatra'
require 'redis'

redis = Redis.new

#################
# HELPER METHODS
#################

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def random_string(length)
    rand(36**length).to_s(36)
  end
end

def good_url?
  params[:url] && !params[:url].empty?
end

##############
# ROUTES
##############


get '/' do
  erb :index
end

post '/' do
  if good_url?
    @shortcode = random_string(5)
    redis.setnx "links:#{@shortcode}", params[:url]
  end
  erb :index
end

get '/:shortcode' do
  @url = redis.get "links#{params[:shortcode]}"
  redirect @url || '/'
end
