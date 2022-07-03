class TwitterApi
  def self.trending_tweets(id: 23424768)
    client.trends(id = id, options = {})
  end

  def self.available_brazilian_cities
    available_places.select { |place| place.country == "Brazil" && place.place_type == "Town"}
  end

  def self.available_places
    client.trends_available
  end

  private

  def self.client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = APP_CONFIG::TWITTER::CONSUMER_KEY
      config.consumer_secret     = APP_CONFIG::TWITTER::CONSUMER_SECRET
      config.access_token        = APP_CONFIG::TWITTER::ACCESS_TOKEN
      config.access_token_secret = APP_CONFIG::TWITTER::ACCESS_TOKEN_SECRET
    end
  end
end