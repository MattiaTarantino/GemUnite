class LatestNewsController < ApplicationController
  require 'json'
  # GET /latest_news or /latest_news.json
  def index
    newsapi = News.new("4ee60b1af31f4bd1b9b41fd4c4399b2f")

    @user = current_user
    topics = @user.fields.pluck("nome").join(' OR ')


    current_date = Time.now.strftime("%Y-%m-%d")
    from_date = (Time.now - 1.month + 1.day).strftime("%Y-%m-%d")

    if !topics || topics == ""
      topics = "Technology"
    end

    @all_articles = newsapi.get_everything(q: topics,
                                           from: from_date,
                                           to: current_date,
                                           language: 'en',
                                           sortBy: 'relevancy',
                                           page: 2)
    @all_articles = JSON.parse(@all_articles.to_json)[..5]  # prendo le prime 5 notizie


  end



end
