class CachedPage
  def doc
    @doc ||= begin
      cache_path = Pathname("cache/#{cache_key.join("/")}.gz")
      cache_path.parent.mkpath

      unless cache_path.exist?
        response = HTTParty.get(page_url)
        raise unless response.ok?
        data_compressed = Zlib::Deflate.deflate(response.body)
        cache_path.write(data_compressed)
      end

      data_compressed = cache_path.read
      Nokogiri::HTML(Zlib::Inflate.inflate(data_compressed))
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
