class GathererQueryPage < CachedPage
  def initialize(params, page=0)
    @params = params
    @page = page
  end

  def page_url
    Addressable::URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx").tap{|u|
      u.query_values = @params.merge(
        action: "advanced",
        output: "checklist",
        page: @page,
      )
    }
  end

  def cache_key
    ["gatherer", "query", Digest::SHA1.hexdigest(@params.inspect), @page]
  end

  def cards
    unless @cards
      @cards = []
      doc.css(".cardItem").each do |row|
        id = row.at("a")["href"][/multiverseid=\K\d+\z/].to_i
        name = row.css("td")[1].text
        set = row.css(".set").text
        number = row.css(".number").text
        @cards << [name, id, set, number]
      end
    end
    @cards
  end

  def last_page
    @last_page ||= (doc.css(".pagingcontrols").last.css("a").map{|u|
      Addressable::URI.parse(u["href"]).query_values["page"].to_i
    }.max || 0)
  end

  def last_page?
    @page == last_page
  end

  def next_page
    return if last_page?
    GathererQueryPage.new(@params, @page+1)
  end

  # Not the most amazing API ever
  def self.parse_url(url)
    base_url = "https://gatherer.wizards.com/Pages/Search/Default.aspx"
    bu = Addressable::URI.parse(base_url)
    u = Addressable::URI.parse(url)
    unless u.scheme == bu.scheme and u.host == bu.host and u.path == bu.path
      warn "Expect the URL to differ from #{base_url} only in query part, ignoring everything except query"
    end
    qv = u.query_values
    qv.delete "action"
    qv.delete "output"
    qv.delete "page"
    qv
  end
end
