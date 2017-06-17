require "httparty"
require "nokogiri"
require "pathname"

class GathererPage
  def initialize(id)
    @id = id
  end

  def page_url
    "http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=#{@id}"
  end

  def doc
    @doc ||= begin
      cache_path = Pathname("cache/gatherer-card-details-#{@id}")
      cache_path.parent.mkpath
      unless cache_path.exist?
        response = HTTParty.get(page_url)
        raise unless response.ok?
        cache_path.write(response.body)
      end
      Nokogiri::HTML(cache_path.read)
    end
  end

  def card_info_rows
    @card_info_rows ||= begin
      rows = doc.css(".row").map{|x| [x.css(".label").text.strip.sub(/:\z/, ""), x.css(".value") ] }
      raise "Duplicated row" if rows.map(&:first).uniq.size != rows.size
      rows.to_h
    end
  end

  def card_name
    @card_name ||= card_info_rows["Card Name"].text.strip
  end

  def mana_cost
    @mana_cost ||= card_info_rows["Mana Cost"].css("img").map{|i| i["alt"]}.join
  end

  def converted_mana_cost
    @converted_mana_cost ||= begin
      cmc = card_info_rows["Converted Mana Cost"].text.strip
      raise "Bad cmc: #{cmc.inspect}" unless cmc =~ /\A\d+\z/
      cmc.to_i
    end
  end

  def artist
    @artist ||= card_info_rows["Artist"].at("a").text
  end

  def rarity
    @rarity ||= card_info_rows["Rarity"].at("span").text
  end

  def types
    @types ||= card_info_rows["Types"].text.strip
  end

  def rulings
    @rulings ||= doc.at(".rulingsTable").css("tr").map{|row| row.css("td").map(&:text) }
  end

  def card_text
    @card_text ||= card_info_rows["Card Text"].at(".cardtextbox").text
  end

  def expansion
    @expansion ||= card_info_rows["Expansion"].at("a img")["title"]
  end

  def all_sets
    @all_sets ||= card_info_rows["All Sets"].css("a").map{|a|
      [a["href"][/multiverseid=\K\d+\z/].to_i, a.at("img")["title"]]
    }
  end
end
