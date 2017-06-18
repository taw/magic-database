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
          if name =~ /\A(\d+|[WUBRGXYZC])\z/
            text = "{#{name}}"
          elsif name =~ /\A([WUBRG])P\z/
            text = "{#{$1}/P}"
          elsif name =~ /\Ap\z/
            text = "{P}"
          elsif name =~ /\Ae\z/
            text = "{E}"
          elsif name =~ /\Atap\z/
            text = "{T}"
          elsif name =~ /\A([WUBRG])([WUBRG])\z/
            text = "{#{$1}/#{$2}}"
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

  def card_info_rows
    @card_info_rows ||= begin
      rows = doc.css(".row").map{|x| [x.css(".label").text.strip.sub(/:\z/, ""), x.css(".value") ] }
      raise "Duplicated row" if rows.map(&:first).uniq.size != rows.size
      rows.to_h
    end
  end

  def card_info
    unless @card_info
      @card_info = {}
      card_info_rows.each do |header, value|
        case header
        when "All Sets"
          @card_info[:all_sets] = value.css("a").map{|a|
            [a["href"][/multiverseid=\K\d+\z/].to_i, a.at("img")["title"]]
          }
        when "Artist"
          @card_info[:artist] = value.text.strip
        when "Card Name"
          @card_info[:card_name] = value.text.strip
        when "Card Number"
          @card_info[:card_number] = value.text.strip
        when "Card Text"
          @card_info[:card_text] = value.css(".cardtextbox").map(&:text).join("\n")
        when "Converted Mana Cost"
          @card_info[:converted_mana_cost] = Integer(value.text.strip, 10)
        when "Expansion"
          @card_info[:expansion] = value.at("a img")["title"]
        when "Flavor Text"
          @card_info[:flavor_text] = value.css(".flavortextbox").map(&:text).join("\n")
        when "Loyalty"
          @card_info[:loyalty] = value.text.strip
        when "Mana Cost"
          @card_info[:mana_cost] = value.css("img").map(&:text).join
        when "P/T"
          @card_info[:power], @card_info[:toughness] = value.text.strip.split("/", 2).map(&:strip)
        when "Rarity"
          @card_info[:rarity] = value.at("span").text
        when "Types"
          @card_info[:types] = value.text.strip.gsub(/\s+/, " ")
        when "Watermark"
          @card_info[:watermark] = value.text.strip
        else
          warn "Unknown header #{header}"
        end
      end
    end
    @card_info
  end

  %I[
    all_sets artist card_name card_number card_text converted_mana_cost expansion
    flavor_text loyalty mana_cost power toughness rarity types watermark
  ].each do |m|
    define_method(m) { card_info[m] }
  end

  def rulings
    @rulings ||= doc.at(".rulingsTable").css("tr").map{|row| row.css("td").map(&:text) }
  end
end
