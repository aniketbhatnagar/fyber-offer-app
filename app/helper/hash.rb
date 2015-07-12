require 'digest/sha1'

module HashHelper

  def generateHash(params, apiKey)
    keysSorted = params.keys.sort
    serializedParams = ""
    keysSorted.each do |key|
      value = params[key]
      serializedParams = serializedParams + key + "=" + value + "&"
    end
    serializedParams = serializedParams + apiKey
    return Digest::SHA1.hexdigest serializedParams
  end

  module_function :generateHash

end