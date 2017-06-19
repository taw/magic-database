class GathererSetChecklistPage < CachedPage
  def initialize(set_name, page=0)
    @set_name = set_name
    @page = page
  end

  def page_url
    Addressable::URI.parse("http://gatherer.wizards.com/Pages/Search/Default.aspx").tap{|u|
      u.query_values = {
        page: @page,
        output: "checklist",
        action: "advanced",
        set: %Q[["#{@set_name}"]]
      }
    }
  end

  def cache_key
    ["gatherer", "set-checklist", @set_name.scan(/\w+/).join("-"), @page]
  end

  def cards
    unless @cards
      @cards = {}
      doc.css(".cardItem").each do |row|
        id = row.at("a")["href"][/multiverseid=\K\d+\z/].to_i
        name = row.css("td")[1].text
        @cards[name] ||= [id, 0]
        @cards[name][1] += 1
      end
      @cards = @cards.map{|name, (first_id, count)| [name, first_id, count]}.sort
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
    GathererSetChecklistPage.new(@set_name, @page+1)
  end
end
