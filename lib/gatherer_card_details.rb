class GathererCardDetails
  def initialize(node, page)
    @node = node
    @page = page
  end

  private def card_info_rows
    @card_info_rows ||= begin
      rows = @node.css(".row").map{|x|
        [x.css(".label").text.strip.sub(/:\z/, ""), x.css(".value")]
      }
      raise "Duplicated row" if rows.map(&:first).uniq.size != rows.size
      rows.to_h
    end
  end

  private def card_info
    unless @card_info
      @card_info = {}
      card_info_rows.each do |header, value|
        case header
        when "All Sets"
          @card_info[:all_sets] = value.css("a").map{|a|
            id = a["href"][/multiverseid=\K\d+\z/].to_i
            expansion_name_and_rarity = a.at("img")["title"]
            raise unless expansion_name_and_rarity =~ /\A(.*?) \((.*)\)\z/
            [id, $1, $2]
          }
        when "Artist"
          @card_info[:artist] = value.text.strip
        when "Card Name"
          @card_info[:name] = value.text.strip
        when "Card Number"
          @card_info[:number] = value.text.strip
        when "Card Text"
          @card_info[:text] = value.css(".cardtextbox").map(&:text).join("\n")
        when "Color Indicator"
          @card_info[:color_indicator] = value.text.strip
        when "Community Rating"
          # Completely ignore this
        when "Converted Mana Cost"
          @card_info[:converted_mana_cost] = begin
            Integer(value.text.strip, 10)
          rescue
            # unsets
            Float(value.text.strip)
          end
        when "Expansion"
          @card_info[:expansion] = value.at("a img")["title"]
          @card_info[:id] = value.at("a")["href"][/multiverseid=\K\d+\z/].to_i
        when "Flavor Text"
          @card_info[:flavor_text] = value.css(".flavortextbox").map(&:text).join("\n")
        when "Loyalty"
          value = value.text.strip
          @card_info[:loyalty] = (Integer(value) rescue value)
        when "Mana Cost"
          @card_info[:mana_cost] = value.css("img").map(&:text).join
        when "P/T"
          # Unset support
          value = value.text.strip.gsub("{1/2}", ".5")
          @card_info[:power], @card_info[:toughness] = value.split(" / ", 2).map(&:strip)
        when "Rarity"
          @card_info[:rarity] = value.at("span").text
        when "Types"
          @card_info[:typeline] = value.text.strip.gsub(/\s+/, " ")
          @card_info[:supertypes], @card_info[:types], @card_info[:subtypes] = parse_typeline(@card_info[:typeline])
        when "Watermark"
          @card_info[:watermark] = value.text.strip
        else
          warn "Unknown header #{header}"
        end
      end
    end
    @card_info
  end

  def variations
    unless defined?(@variations)
      @variations = @node.at(".variations").css("a").map{|a| a["href"][/multiverseid=\K\d+\z/].to_i }
      @variations = nil if @variations == []
    end
    @variations
  end

  def current_variation
    return unless variations
    (variations.index(id) or raise "Current id not on the list of variations") + 1
  end

  %I[
    all_sets artist name number text converted_mana_cost expansion
    flavor_text loyalty mana_cost power toughness rarity typeline watermark
    subtypes types supertypes id color_indicator
  ].each do |m|
    define_method(m) { card_info[m] }
  end

  def rulings
    @rulings ||= @node.css(".rulingsTable tr").map{|row|
      # Date is in retarded US format
      date, text = row.css("td").map(&:text)
      m,d,y = date.split("/")
      date = "%04d-%02d-%02d" % [y,m,d]
      [date, text]
    }
  end

  def colors
    unless @colors
      if color_indicator
        @colors = []
        @colors << "White" if color_indicator =~ /\bWhite\b/
        @colors << "Blue"  if color_indicator =~ /\bBlue\b/
        @colors << "Black" if color_indicator =~ /\bBlack\b/
        @colors << "Red"   if color_indicator =~ /\bRed\b/
        @colors << "Green" if color_indicator =~ /\bGreen\b/
      elsif text =~ /\bDevoid\b/
        @colors = []
      else
        @colors = []
        @colors << "White" if mana_cost =~ /W/i
        @colors << "Blue"  if mana_cost =~ /U/i
        @colors << "Black" if mana_cost =~ /B/i
        @colors << "Red"   if mana_cost =~ /R/i
        @colors << "Green" if mana_cost =~ /G/i
      end
    end
    @colors
  end

  # This actually depends on other side as well
  def color_identity
    unless @color_identity
      @color_identity = []
      @color_identity << "W" if mana_cost =~ /W/i or text =~ /\{W\}/ or subtypes.include?("Plains") or color_indicator =~ /\bWhite\b/
      @color_identity << "U" if mana_cost =~ /U/i or text =~ /\{U\}/ or subtypes.include?("Island") or color_indicator =~ /\bBlue\b/
      @color_identity << "B" if mana_cost =~ /B/i or text =~ /\{B\}/ or subtypes.include?("Swamp") or color_indicator =~ /\bBlack\b/
      @color_identity << "R" if mana_cost =~ /R/i or text =~ /\{R\}/ or subtypes.include?("Mountain") or color_indicator =~ /\bRed\b/
      @color_identity << "G" if mana_cost =~ /G/i or text =~ /\{G\}/ or subtypes.include?("Forest") or color_indicator =~ /\bGreen\b/
    end
    @color_identity
  end

  def has_multiple_parts?
    unless defined?(@has_multiple_parts)
      @has_multiple_parts = (@page.card_details_boxes.size > 1)
    end
    @has_multiple_parts
  end

  def names
    return unless has_multiple_parts?
    @names ||= @page.card_details_boxes.map(&:name)
  end

  def layout
    @layout ||= begin
      if has_multiple_parts?
        "double-faced"
      elsif text =~ /\ALevel up/
        "leveler"
      else
        "normal"
      end
    end
  end

  private def parse_typeline(typeline)
    known_supertypes = ["Basic", "Legendary", "Ongoing", "Snow", "World"]
    supertypes, types, subtypes = [], [], []
    if typeline =~ /(.*) \u2014 (.*)/
      subtypes = $2.split(" ")
      typeline = $1
    end
    types = typeline.split(" ")
    supertypes = types & known_supertypes
    types -= known_supertypes
    return supertypes, types, subtypes
  end
end
