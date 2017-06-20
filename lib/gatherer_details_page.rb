class GathererDetailsPage < CachedPage
  def initialize(id)
    @id = id
  end

  def doc
    unless @doc
      super
      doc.css("img").each do |img|
        if img["src"].start_with?("/Handlers/Image.ashx")
          name = Addressable::URI.parse(img["src"]).query_values["name"]
          text = case name
          when "500"
            # Unset irregularity
            "{hw}"
          when /\A(\d+|[WUBRGXYZC])\z/
            "{#{name}}"
          when /\A([WUBRG])P\z/
            "{#{$1}/P}"
          when /\A2([WUBRG])\z/
            "{2/#{$1}}"
          when /\A([WUBRG])([WUBRG])\z/
            "{#{$1}/#{$2}}"
          when "p"
            "{P}"
          when "e"
            "{E}"
          when "tap"
            "{T}"
          when "untap"
            "{Q}"
          when "snow"
            "{S}"
          when "HalfR"
            # Unsets
            "{hr}"
          when "HalfW"
            # Unsets
            "{hw}"
          when "Infinity"
            # Unsets
            "{∞}"
          else
            warn "No idea what kind of symbol is #{name}"
            next
          end
          raise "Tag already has inner html" unless img.inner_html.empty?
          img.inner_html = text
        end
      end
    end
    @doc
  end

  def page_url
    "http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=#{@id}"
  end

  def cache_key
    ["gatherer", "details", @id / 1000, @id % 1000]
  end

  def card_details_boxes
    @card_details_boxes ||= doc.css(".cardDetails").map{|node|
      GathererCardDetails.new(node, self)
    }
  end

  def primary_card_details_box
    card_details_boxes.find{|c| c.id == @id} or raise "Can't find primary card box on page for #{@id}"
  end
end
