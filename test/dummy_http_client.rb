require './app/helpers/http_client'
class DummyHttpClient
  include HttpClient

  def initialize(response)
    @response = response
  end

  def get(url, headers, queryParams)
    return @response
  end
end