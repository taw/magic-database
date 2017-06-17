class GathererSetChecklistPage < CachedPage
  def initialize(set_name, page)
    @set_name = set_name
    @page = page
  end

  def page_url
    "http://gatherer.wizards.com/Pages/Search/Default.aspx?page=#{@page}&output=checklist&action=advanced&set=%5b%22#{@set_name}%22%5d"
  end

  def cache_key
    "gatherer-set-checklist-#{@set_name.scan(/\w+/).join("-")}-#{@page}"
  end

  def cards
    @cards ||= doc.css(".cardItem").map{|row|
      [row.at("a")["href"][/multiverseid=\K\d+\z/].to_i, *row.css("td").map(&:text)]
    }
  end

  def last_page
    @last_page ||= (doc.css(".pagingcontrols").last.css("a").map{|u|
      Addressable::URI.parse(u["href"]).query_values["page"].to_i
    }.max || 0)
  end
end
