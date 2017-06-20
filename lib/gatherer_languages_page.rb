class GathererLanguagesPage < CachedPage
  def initialize(id)
    @id = id
  end

  def page_url
    "http://gatherer.wizards.com/Pages/Card/Languages.aspx?multiverseid=#{@id}"
  end

  def cache_key
    ["gatherer", "languages", @id / 1000, @id % 1000]
  end

  def languages
    @languages ||= doc.css(".cardItem").map{|row|
      [row.at("a")["href"][/multiverseid=\K\d+\z/].to_i, *row.css("td").map{|e| e.text.strip}]
    }
  end
end
