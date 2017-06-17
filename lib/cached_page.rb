class CachedPage
  def doc
    @doc ||= begin
      cache_path = Pathname("cache/#{cache_key}")
      cache_path.parent.mkpath
      unless cache_path.exist?
        response = HTTParty.get(page_url)
        raise unless response.ok?
        cache_path.write(response.body)
      end
      Nokogiri::HTML(cache_path.read)
    end
  end
end
