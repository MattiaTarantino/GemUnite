require "application_system_test_case"

class ProgettosTest < ApplicationSystemTestCase
  setup do
    @progetto = progettos(:one)
  end

  test "visiting the index" do
    visit progettos_url
    assert_selector "h1", text: "Progettos"
  end

  test "should create progetto" do
    visit progettos_url
    click_on "New progetto"

    fill_in "Descrizione", with: @progetto.descrizione
    fill_in "Dimensione", with: @progetto.dimensione
    fill_in "Id progetto", with: @progetto.id_progetto
    fill_in "Info leader", with: @progetto.info_leader
    fill_in "Stato", with: @progetto.stato
    click_on "Create Progetto"

    assert_text "Progetto was successfully created"
    click_on "Back"
  end

  test "should update Progetto" do
    visit progetto_url(@progetto)
    click_on "Edit this progetto", match: :first

    fill_in "Descrizione", with: @progetto.descrizione
    fill_in "Dimensione", with: @progetto.dimensione
    fill_in "Id progetto", with: @progetto.id_progetto
    fill_in "Info leader", with: @progetto.info_leader
    fill_in "Stato", with: @progetto.stato
    click_on "Update Progetto"

    assert_text "Progetto was successfully updated"
    click_on "Back"
  end

  test "should destroy Progetto" do
    visit progetto_url(@progetto)
    click_on "Destroy this progetto", match: :first

    assert_text "Progetto was successfully destroyed"
  end
end
