require 'faye'
require 'faye/redis'

bayeux = Faye::RackAdapter.new(
  :mount   => '/faye',
  :timeout => 25,
  :engine  => {
    :type  => Faye::Redis,
    :uri   => ENV['REDISTOGO_URL'],
  }
)
run bayeux
