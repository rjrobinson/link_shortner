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

##############
# ROUTES
##############


get '/' do
  erb :index
end
