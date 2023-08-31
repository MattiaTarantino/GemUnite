require "application_system_test_case"

class RichiestaTest < ApplicationSystemTestCase
  setup do
    @richiestum = richiesta(:one)
  end

  test "visiting the index" do
    visit richiesta_url
    assert_selector "h1", text: "Richiesta"
  end

  test "should create richiestum" do
    visit richiesta_url
    click_on "New richiestum"

    fill_in "Id", with: @richiestum.id
    fill_in "Note", with: @richiestum.note
    check "Stato accettazione" if @richiestum.stato_accettazione
    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "should update Request" do
    visit richiestum_url(@richiestum)
    click_on "Edit this richiestum", match: :first

    fill_in "Id", with: @richiestum.id
    fill_in "Note", with: @richiestum.note
    check "Stato accettazione" if @richiestum.stato_accettazione
    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "should destroy Request" do
    visit richiestum_url(@richiestum)
    click_on "Destroy this richiestum", match: :first

    assert_text "Request was successfully destroyed"
  end
end
