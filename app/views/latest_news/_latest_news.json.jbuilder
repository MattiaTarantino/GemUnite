json.extract! latest_news, :id, :created_at, :updated_at
json.url latest_news_url(latest_news, format: :json)
