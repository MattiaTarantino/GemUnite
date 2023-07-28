require "application_system_test_case"

class LatestNewsTest < ApplicationSystemTestCase
  setup do
    @latest_news = latest_news(:one)
  end

  test "visiting the index" do
    visit latest_news_url
    assert_selector "h1", text: "Latest news"
  end

  test "should create latest news" do
    visit latest_news_url
    click_on "New latest news"

    click_on "Create Latest news"

    assert_text "Latest news was successfully created"
    click_on "Back"
  end

  test "should update Latest news" do
    visit latest_news_url(@latest_news)
    click_on "Edit this latest news", match: :first

    click_on "Update Latest news"

    assert_text "Latest news was successfully updated"
    click_on "Back"
  end

  test "should destroy Latest news" do
    visit latest_news_url(@latest_news)
    click_on "Destroy this latest news", match: :first

    assert_text "Latest news was successfully destroyed"
  end
end
