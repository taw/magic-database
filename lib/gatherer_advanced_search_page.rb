class GathererAdvancedSearchPage < CachedPage
  def page_url
    "http://gatherer.wizards.com/Pages/Advanced.aspx"
  end

  def cache_key
    ["gatherer", "advanced_search"]
  end

  def set_names
    @set_names ||= doc.css("#autoCompleteSourceBoxsetAddText0_InnerTextBoxcontainer a").map(&:text)
  end
end
