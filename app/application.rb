require './app/helpers/hash'
require './app/helpers/http_client'
require './app/services/offers'

module Application
  defaultParams = Hash["appid" => "157", "format" => "json", "device_id" => "2b6f0cc904d137be2e1730235f5664094b83", "locale" => "de", "ip" => "109.235.143.113", "offer_types" => "112"]
  @offersService = Offers.new("http://api.sponsorpay.com/feed/v1/offers.json", "b07a12df7d52e6c118e5d47d3f9e60135b109a1f", defaultParams, HashHelper, HttpClient)

  def self.offersService
    @offersService
  end

end