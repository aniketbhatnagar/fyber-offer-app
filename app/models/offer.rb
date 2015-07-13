class Offer
  def initialize(id, title, thumbnailLowRes, payout, link)
    @id = id
    @title = title
    @thumbnailLowRes = thumbnailLowRes
    @payout = payout
    @link = link
  end

  def id
    @id
  end

  def title
    @title
  end

  def thumbnailLowRes
    @thumbnailLowRes
  end

  def payout
    @payout
  end

  def link
    @link
  end

  def to_s
    "Offer(#@id, #@title, #@thumbnailLowRes, #@payout, #@link)"
  end
end