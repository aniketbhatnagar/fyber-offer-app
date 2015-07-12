require 'goliath'

class Application < Goliath::API

  def response(env)
    [200, {}, "Hello world!"]
  end

end