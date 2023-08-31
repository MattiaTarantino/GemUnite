require "test_helper"

class LatestNewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @latest_news = latest_news(:one)
  end

  test "should get index" do
    get latest_news_index_url
    assert_response :success
  end

  test "should get new" do
    get new_latest_news_url
    assert_response :success
  end

  test "should create latest_news" do
    assert_difference("LatestNews.count") do
      post latest_news_index_url, params: { latest_news: {  } }
    end

    assert_redirected_to latest_news_url(LatestNews.last)
  end

  test "should show latest_news" do
    get latest_news_url(@latest_news)
    assert_response :success
  end

  test "should get edit" do
    get edit_latest_news_url(@latest_news)
    assert_response :success
  end

  test "should update latest_news" do
    patch latest_news_url(@latest_news), params: { latest_news: {  } }
    assert_redirected_to latest_news_url(@latest_news)
  end

  test "should destroy latest_news" do
    assert_difference("LatestNews.count", -1) do
      delete latest_news_url(@latest_news)
    end

    assert_redirected_to latest_news_index_url
  end
end
