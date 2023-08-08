require "test_helper"

class RichiestaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @richiestum = richiesta(:one)
  end

  test "should get index" do
    get richiesta_url
    assert_response :success
  end

  test "should get new" do
    get new_richiestum_url
    assert_response :success
  end

  test "should create richiestum" do
    assert_difference("Request.count") do
      post richiesta_url, params: { richiestum: { id: @richiestum.id, note: @richiestum.note, stato_accettazione: @richiestum.stato_accettazione } }
    end

    assert_redirected_to richiestum_url(Request.last)
  end

  test "should show richiestum" do
    get richiestum_url(@richiestum)
    assert_response :success
  end

  test "should get edit" do
    get edit_richiestum_url(@richiestum)
    assert_response :success
  end

  test "should update richiestum" do
    patch richiestum_url(@richiestum), params: { richiestum: { id: @richiestum.id, note: @richiestum.note, stato_accettazione: @richiestum.stato_accettazione } }
    assert_redirected_to richiestum_url(@richiestum)
  end

  test "should destroy richiestum" do
    assert_difference("Request.count", -1) do
      delete richiestum_url(@richiestum)
    end

    assert_redirected_to richiesta_url
  end
end
