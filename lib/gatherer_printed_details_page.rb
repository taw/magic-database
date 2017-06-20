class GathererPrintedDetailsPage < GathererDetailsPage
  def page_url
    "http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=true&multiverseid=#{@id}"
  end

  def cache_key
    ["gatherer", "printed-details", @id / 1000, @id % 1000]
  end

  def card_details_boxes
    @card_details_boxes ||= doc.css(".cardDetails").map{|node| GathererCardPrintedDetails.new(node) }
  end
end
