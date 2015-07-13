require './app/helpers/hash'
require "test/unit"

class TestHash < Test::Unit::TestCase

  def test_hash
    apiKey = "e95a21621a1865bcbae3bee89c4d4f84"
    params = Hash[
        "appid" => "157",
        "device_id" => "2b6f0cc904d137be2e1730235f5664094b831186",
        "ip" => "212.45.111.17",
        "locale" => "de",
        "page" => "2",
        "ps_time" => "1312211903",
        "pub0" => "campaign2",
        "timestamp" => "1312553361",
        "uid" => "player1"
    ]
    hash = HashHelper.generateHash(params, apiKey)
    expected = "7a2b1604c03d46eec1ecd4a686787b75dd693c4d"
    assert(hash == expected, "Hashing incorrect - " + hash + " != " + expected)
  end
end