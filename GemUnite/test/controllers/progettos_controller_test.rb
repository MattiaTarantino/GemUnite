require "test_helper"

class ProgettosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @progetto = progettos(:one)
  end

  test "should get index" do
    get progettos_url
    assert_response :success
  end

  test "should get new" do
    get new_progetto_url
    assert_response :success
  end

  test "should create progetto" do
    assert_difference("Progetto.count") do
      post progettos_url, params: { progetto: { descrizione: @progetto.descrizione, dimensione: @progetto.dimensione, id_progetto: @progetto.id_progetto, info_leader: @progetto.info_leader, stato: @progetto.stato } }
    end

    assert_redirected_to progetto_url(Progetto.last)
  end

  test "should show progetto" do
    get progetto_url(@progetto)
    assert_response :success
  end

  test "should get edit" do
    get edit_progetto_url(@progetto)
    assert_response :success
  end

  test "should update progetto" do
    patch progetto_url(@progetto), params: { progetto: { descrizione: @progetto.descrizione, dimensione: @progetto.dimensione, id_progetto: @progetto.id_progetto, info_leader: @progetto.info_leader, stato: @progetto.stato } }
    assert_redirected_to progetto_url(@progetto)
  end

  test "should destroy progetto" do
    assert_difference("Progetto.count", -1) do
      delete progetto_url(@progetto)
    end

    assert_redirected_to progettos_url
  end
end
