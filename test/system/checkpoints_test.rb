require "application_system_test_case"

class CheckpointsTest < ApplicationSystemTestCase
  setup do
    @checkpoint = checkpoints(:one)
  end

  test "visiting the index" do
    visit checkpoints_url
    assert_selector "h1", text: "Checkpoints"
  end

  test "should create checkpoint" do
    visit checkpoints_url
    click_on "New checkpoint"

    fill_in "Completato", with: @checkpoint.completato
    fill_in "Descrizione", with: @checkpoint.descrizione
    fill_in "Nome", with: @checkpoint.nome
    click_on "Create Checkpoint"

    assert_text "Checkpoint was successfully created"
    click_on "Back"
  end

  test "should update Checkpoint" do
    visit checkpoint_url(@checkpoint)
    click_on "Edit this checkpoint", match: :first

    fill_in "Completato", with: @checkpoint.completato
    fill_in "Descrizione", with: @checkpoint.descrizione
    fill_in "Nome", with: @checkpoint.nome
    click_on "Update Checkpoint"

    assert_text "Checkpoint was successfully updated"
    click_on "Back"
  end

  test "should destroy Checkpoint" do
    visit checkpoint_url(@checkpoint)
    click_on "Destroy this checkpoint", match: :first

    assert_text "Checkpoint was successfully destroyed"
  end
end
