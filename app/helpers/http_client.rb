require 'em-synchrony'
require 'em-synchrony/em-http'

module HttpClient
  def self.get(url, headers, queryParams)
    http = EM::HttpRequest.new(url).get :headers => headers, :query => queryParams
    resp = http.response
    headers = http.response_header
    HttpResponse.new(headers, resp)
  end
end

class HttpResponse
  def initialize(headers, body)
    @headers = headers
    @body = body
  end
  def body
    @body
  end
  def headers
    @headers
  end
end