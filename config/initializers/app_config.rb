CONFIG = YAML.load_file(Rails.root.join("config/app.yml"))[Rails.env]

module APP_CONFIG
  module TWITTER
    CONSUMER_KEY        = CONFIG["twitter"]["consumer_key"]
    CONSUMER_SECRET     = CONFIG["twitter"]["consumer_secret"]
    ACCESS_TOKEN        = CONFIG["twitter"]["access_token"]
    ACCESS_TOKEN_SECRET = CONFIG["twitter"]["access_token_secret"]
  end

  module NEWS
    API_KEY = CONFIG["news_api"]["api_key"]
  end
end