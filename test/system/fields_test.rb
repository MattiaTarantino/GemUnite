require "application_system_test_case"

class FieldsTest < ApplicationSystemTestCase
  setup do
    @field = fields(:one)
  end

  test "visiting the index" do
    visit fields_url
    assert_selector "h1", text: "Fields"
  end

  test "should create field" do
    visit fields_url
    click_on "New field"

    fill_in "Nome", with: @field.nome
    click_on "Create Field"

    assert_text "Field was successfully created"
    click_on "Back"
  end

  test "should update Field" do
    visit field_url(@field)
    click_on "Edit this field", match: :first

    fill_in "Nome", with: @field.nome
    click_on "Update Field"

    assert_text "Field was successfully updated"
    click_on "Back"
  end

  test "should destroy Field" do
    visit field_url(@field)
    click_on "Destroy this field", match: :first

    assert_text "Field was successfully destroyed"
  end
end
