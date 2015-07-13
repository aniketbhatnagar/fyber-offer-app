require 'digest/sha1'

module HashHelper

  def self.generateHash(params, apiKey)
    keysSorted = params.keys.sort
    serializedParams = ''
    keysSorted.each do |key|
      value = params[key]
      serializedParams = serializedParams + key + '=' + value + '&'
    end
    serializedParams = serializedParams + apiKey
    return hash(serializedParams)
  end

  def self.hash(msg)
    return Digest::SHA1.hexdigest msg
  end

end