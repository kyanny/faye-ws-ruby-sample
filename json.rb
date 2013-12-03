require 'grape'
require 'redis'
require 'active_support/core_ext'
require 'faye'
require 'eventmachine'

class JsonApi < Grape::API
  version 'v1'
  format :json
  default_format :json

  resources :messaging do
    get '/' do
      header 'Access-Control-Allow-Origin', '*'
      { ping: :pong }
    end

    post '/' do
      header 'Access-Control-Allow-Origin', '*'

      EM.run {
        Signal.trap("INT") { EM.stop }
        Signal.trap("TERM") { EM.stop }
        Signal.trap("QUIT") { EM.stop }

        client = Faye::Client.new('http://localhost:9002/faye')
        client.publish('/messages/new', text: params[:message])
        # Redis.new(url: ENV['REDISTOGO_URL']).publish 'message.create', params.to_json
      }
      { ok: true }
    end
  end
end
