class CachedPage
  def doc
    @doc ||= begin
      cache_path = Pathname("cache/#{cache_key.join("/")}.gz")
      cache_path.parent.mkpath

      unless cache_path.exist?
        response = HTTParty.get(page_url)
        # FFS, 200 code but Server Error
        raise if response.body.include?("Server Error - Gatherer")
        raise unless response.ok?
        Zlib::GzipWriter.open(cache_path) do |gz|
          gz.write response.body
        end
      end
      data = Zlib::GzipReader.open(cache_path, &:read)
      Nokogiri::HTML(data.tr("\r", ""))
    end
  end

  def ==(other)
    self.class == other.class and self.page_url == other.page_url
  end

  def inspect
    "#{self.class}<#{page_url}>"
  end

  def to_s
    inspect
  end
end
