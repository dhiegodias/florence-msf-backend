class NewsApi
  def self.build
    new(
      base_url: "https://newsdata.io/api/1/news",
      api_key: APP_CONFIG::NEWS::API_KEY
    )
  end

  def initialize(base_url:, api_key:)
    @base_url = base_url
    @api_key = api_key
  end

  def get_by_keywords(keywords:)
    params = build_params(keywords: keywords)
    RestClient.get(@base_url, { params: params })
  end

  private

  def build_params(keywords:)
    {
      apikey: @api_key,
      category: categories,
      q: build_search_params(keywords: keywords)
    }
  end

  def categories
    "environment,health,politics"
  end

  def build_search_params(keywords:)
    length = keywords.length
    query = ""
    keywords.each_with_index do | word, index |
      query << word
      query << "%20OR%20" unless last_word?(index, length)
    end
    query
  end

  def last_word?(index, length)
    return true if index +1 == length
    false
  end
end