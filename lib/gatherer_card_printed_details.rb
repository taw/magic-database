class GathererCardPrintedDetails
  def initialize(node)
    @node = node
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
        when "Artist"
        when "Card Name"
        when "Card Number"
        when "Card Text"
          @card_info[:text] = value.css(".cardtextbox").map(&:text).join("\n")
        when "Color Indicator"
        when "Community Rating"
        when "Converted Mana Cost"
        when "Expansion"
          @card_info[:id] = value.at("a")["href"][/multiverseid=\K\d+\z/].to_i
        when "Flavor Text"
        when "Loyalty"
        when "Mana Cost"
        when "Other Sets"
        when "P/T"
        when "Rarity"
        when "Types"
          @card_info[:typeline] = value.text.strip.gsub(/\s+/, " ")
        when "Watermark"
        when ""
          next if value.text.strip == ""
          warn "Empty header"
        else
          warn "Unknown header #{header.inspect}"
        end
      end
    end
    @card_info
  end

  %I[
    text typeline id
  ].each do |m|
    define_method(m) { card_info[m] }
  end
end
