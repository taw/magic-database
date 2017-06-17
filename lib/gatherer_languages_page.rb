class GathererLanguagesPage < CachedPage
  def initialize(id)
    @id = id
  end

  def page_url
    "http://gatherer.wizards.com/Pages/Card/Languages.aspx?multiverseid=#{@id}"
  end

  def cache_key
    "gatherer-card-languages-#{@id}"
  end

  def languages
    @languages ||= doc.css(".cardItem").map{|row| row.css("td").map{|e| e.text.strip}}
  end
end
