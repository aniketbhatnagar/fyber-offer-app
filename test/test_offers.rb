require './app/services/offers'
require './app/helpers/hash'
require 'dummy_http_client'
require "test/unit"

class TestOffers < Test::Unit::TestCase

  def test_multiple_offers
    expectedResponse = HttpResponse.new(Hash['X-Sponsorpay-Response-Signature' => 'b857e5cb2f85c72c5c28428dfa63cc708f106165'], '{"code":"OK","message":"Ok","count":30,"pages":5,"information":{"app_name":"Demo iframe for publisher - do not touch","appid":157,"virtual_currency":"Coins","country":"DE","language":"DE","support_url":"http://api.sponsorpay.com/support?appid=157&feed=on&mobile=on&uid=player1"},"offers":[{"title":"Clash of Lords 2: Ehrenkampf","offer_id":266892,"teaser":"Herunterladen und STARTEN","required_actions":"Herunterladen und STARTEN","link":"http://api.sponsorpay.com/6dc8e0ac8b22b591fdc97b323ebc3bbc/47c307f13792cf27/mobile/DE/157/offers/266892","offer_types":[{"offer_type_id":101,"readable":"Download"},{"offer_type_id":106,"readable":"Spiele"},{"offer_type_id":109,"readable":"Spiele"},{"offer_type_id":112,"readable":"Gratis"}],"payout":17781,"time_to_payout":{"amount":300,"readable":"5 Minuten"},"thumbnail":{"lowres":"http://cdn3.sponsorpay.com/app_icons/19476/small_mobile_icon.png","hires":"http://cdn3.sponsorpay.com/app_icons/19476/big_mobile_icon.png"},"store_id":"com.igg.clashoflords2_de"},{"title":"Gratis Prepaid-SIM","offer_id":356777,"teaser":"Bestellen Sie bis zu zwei o2 Loop Freikarten. Jetzt kostenlos bestellen.","required_actions":"Bestellen Sie bis zu zwei o2 Loop Freikarten. Jetzt kostenlos bestellen.","link":"http://api.sponsorpay.com/6dc8e0ac8b22b591fdc97b323ebc3bbc/687af24395c9e5db/mobile/DE/157/offers/356777","offer_types":[{"offer_type_id":105,"readable":"Registrierung"},{"offer_type_id":112,"readable":"Gratis"}],"payout":76772,"time_to_payout":{"amount":600,"readable":"10 Minuten"},"thumbnail":{"lowres":"http://cdn3.sponsorpay.com/assets/15196/offerwall-02_square_60.jpg","hires":"http://cdn3.sponsorpay.com/assets/15196/offerwall-02_square_175.jpg"},"store_id":""}]}')
    offersService = createOffers(expectedResponse)
    offers = offersService.getOffers('', '', '')
    assert(offers.length == 2)
    assertOffer(offers[0], 266892, 'Clash of Lords 2: Ehrenkampf', 'http://cdn3.sponsorpay.com/app_icons/19476/small_mobile_icon.png', 17781, 'http://api.sponsorpay.com/6dc8e0ac8b22b591fdc97b323ebc3bbc/47c307f13792cf27/mobile/DE/157/offers/266892')
    assertOffer(offers[1], 356777, 'Gratis Prepaid-SIM', 'http://cdn3.sponsorpay.com/assets/15196/offerwall-02_square_60.jpg', 76772, 'http://api.sponsorpay.com/6dc8e0ac8b22b591fdc97b323ebc3bbc/687af24395c9e5db/mobile/DE/157/offers/356777')
  end

  def test_invalid_response
    expectedResponse = HttpResponse.new(Hash[], '{"code":"ERROR_INVALID_UID","message":"An invalid user id (uid) was given as a parameter in the request."}')
    offersService = createOffers(expectedResponse)
    errorFound = false
    begin
      offers = offersService.getOffers('', '', '')
    rescue Exception => error
      errorFound = true
      assert(error.message == "An invalid user id (uid) was given as a parameter in the request.")
    end
    assert(errorFound)
  end

  def createOffers(expectedResponse)
    return Offers.new("http://api.sponsorpay.com/feed/v1/offers.json", apiKey, defaultParams, HashHelper, DummyHttpClient.new(expectedResponse))
  end

  private
  def defaultParams
    return Hash[
        "appid" => "157",
        "format" => "json",
        "device_id" => "2b6f0cc904d137be2e1730235f5664094b83",
        "locale" => "de",
        "ip" => "109.235.143.113",
        "offer_types" => "112"
    ]
  end

  private
  def apiKey
    return "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
  end

  private
  def assertOffer(offer, id, title, thumbnailLowRes, payout, link)
    assert(offer.id == id)
    assert(offer.title == title)
    assert(offer.thumbnailLowRes == thumbnailLowRes)
    assert(offer.payout == payout)
    assert(offer.link == link)
  end
end