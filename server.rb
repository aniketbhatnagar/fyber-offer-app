require 'goliath'
require 'fiber_pool'
require 'tilt'
require 'tilt/erb'
require './app/application'

fiber_pool = FiberPool.new(100)

Goliath::Request.execute_block = proc do |&block|
  fiber_pool.spawn(&block)
end


class Frontend < Goliath::API
  include Goliath::Rack::Templates      # render templated files from ./views

  use(Rack::Static,                     # render static files from ./public
      :root => Goliath::Application.app_path("public"),
      :urls => ["/favicon.ico", '/css', '/js', '/images', '/fonts'])

  use Goliath::Rack::Validation::RequestMethod, %w(GET) # allow GET requests only
  use Goliath::Rack::Params # parse & merge query and body parameters

  def response(env)
    uid = env.params['uid']
    if uid.nil?
      [200, {}, erb(:default, :locals => {:uid => nil, :pub0 => nil, :page => nil})]
    else
      pub0 = env.params['pub0']
      page = env.params['page']
      begin

        offers = Application.offersService.getOffers(uid, pub0, page)
        puts(offers)
        [200, {}, erb(:offers, :locals => {:offers => offers, :uid => uid, :pub0 => pub0, :page => page})]
      rescue Exception => error
        [200, {}, erb(:error, :locals => {:errorMsg => error.message, :uid => uid, :pub0 => pub0, :page => page})]
      end
    end
  end

end