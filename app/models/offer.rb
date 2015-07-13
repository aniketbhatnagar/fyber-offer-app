class Offer
  def initialize(id, title, thumbnailLowRes, payout)
    @id = id
    @title = title
    @thumbnailLowRes = thumbnailLowRes
    @payout = payout
  end

  def id
    return @id
  end

  def title
    return @title
  end

  def thumbnailLowRes
    return @thumbnailLowRes
  end

  def payout
    return @payout
  end

  def to_s
    return "Offer(#@id, #@title, #@thumbnailLowRes, #@payout)"
  end
end