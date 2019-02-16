require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

get '/*' do
  JSON.dump(request.env)
end
