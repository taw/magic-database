class GathererPrintingsPage < CachedPage
  def initialize(id)
    @id = id
  end

  def page_url
    "http://gatherer.wizards.com/Pages/Card/Printings.aspx?multiverseid=#{@id}"
  end

  def cache_key
    ["gatherer", "printings", @id / 1000, @id % 1000]
  end

  def legalities
    doc.css(".cardList")[1].css(".cardItem").map{|row| row.css("td")[0,2].map{|e| e.text.strip}}
  end
end
