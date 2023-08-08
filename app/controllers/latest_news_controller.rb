class LatestNewsController < ApplicationController
  before_action :set_latest_news, only: %i[ show edit update destroy ]

  # GET /latest_news or /latest_news.json
  def index

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
