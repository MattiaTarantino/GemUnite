class LatestNewsController < ApplicationController
  require 'json'
  # GET /latest_news or /latest_news.json
  def index
    newsapi = News.new("4ee60b1af31f4bd1b9b41fd4c4399b2f")

    @user = current_user
    topics = ""
    @user.fields.each do |field|
      topics += field.nome + " "
    end

    current_date = Time.now.strftime("%Y-%m-%d")
    from_date = (Time.now - 1.month + 1.day).strftime("%Y-%m-%d")

    if topics == ""
      topics = "IT"
    end

    @all_articles = newsapi.get_everything(q: topics,
                                           from: from_date,
                                           to: current_date,
                                           language: 'en',
                                           sortBy: 'relevancy',
                                           page: 2)
    @all_articles = JSON.parse(@all_articles.to_json)[..5]  # prendo le prime 5 notizie


  end

  # GET /latest_news/1 or /latest_news/1.json
  def show
  end

  # GET /latest_news/new
  def new

  end

  # GET /latest_news/1/edit
  def edit
  end

  # POST /latest_news or /latest_news.json
  def create
  end

  # PATCH/PUT /latest_news/1 or /latest_news/1.json
  def update
  end

  # DELETE /latest_news/1 or /latest_news/1.json
  def destroy
  end

end
