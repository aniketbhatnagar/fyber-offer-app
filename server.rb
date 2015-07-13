require 'goliath'
require './app/helpers/hash'
require './app/helpers/http_client'
require './app/services/offers'
require 'fiber_pool'
require 'tilt'


fiber_pool = FiberPool.new(100)

Goliath::Request.execute_block = proc do |&block|
  fiber_pool.spawn(&block)
end


class Application < Goliath::API


  include Goliath::Rack::Templates      # render templated files from ./views

  use(Rack::Static,                     # render static files from ./public
      :root => Goliath::Application.app_path("public"),
      :urls => ["/favicon.ico", '/stylesheets', '/javascripts', '/images'])

  def response(env)
    defaultParams = Hash["appid" => "157", "format" => "json", "device_id" => "2b6f0cc904d137be2e1730235f5664094b83", "locale" => "de", "ip" => "109.235.143.113", "offer_types" => "112"]
    offersService = Offers.new("http://api.sponsorpay.com/feed/v1/offers.json", "b07a12df7d52e6c118e5d47d3f9e60135b109a1f", defaultParams, HashHelper, HttpClient)
    offers = offersService.getOffers('player1', 'campaign1', '1')
    [200, {}, offers.length]
  end

end