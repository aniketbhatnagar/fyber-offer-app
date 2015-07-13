require './app/helpers/hash'
require './app/helpers/http_client'
require './app/models/offer'
require 'json'

class Offers
  def initialize(url, apiKey, defaultParams, hashHelper, httpClient)
    @url = url
    @apiKey = apiKey
    @defaultParams = defaultParams
    @hashHelper = hashHelper
    @httpclient = httpClient
    assertRequisite()
  end

  def getOffers(uid, pub0, page)
    additionalParams = Hash[
        'uid'       => uid,
        'pub0'      => pub0,
        'page'      => page,
        'timestamp' => "#{Time.now.to_i}"
    ]
    mergedParams = @defaultParams.merge(additionalParams)
    mergedParams['hashkey'] = @hashHelper.generateHash(mergedParams, @apiKey)
    httpResponse = @httpclient.get(@url, Hash['Accept-Encoding' => 'gzip'], mergedParams)
    assertResponse(httpResponse)
    return parseOffers(httpResponse.body)
  end

  private
  def assertResponse(httpResponse)
    responseHash = httpResponse.headers['X-Sponsorpay-Response-Signature']
    toHash = httpResponse.body + @apiKey
    generatedHash = @hashHelper.hash(toHash)
    raise "response validation failed" unless generatedHash.eql?(responseHash)
  end

  private
  def parseOffers(response)
    parsed = JSON.parse(response)
    offers = parsed['offers'].map { |offerJson|
      Offer.new(offerJson['offer_id'], offerJson['title'], offerJson['thumbnail']['lowres'], offerJson['payout'])
    }
    return offers
  end

  private
  def assertRequisite()
    raise "appid not supplied in defaultParams" unless @defaultParams.key? "appid"
  end
end