require "application_system_test_case"

class DeliveriesTest < ApplicationSystemTestCase
  setup do
    @delivery = deliveries(:one)
  end

  test "visiting the index" do
    visit deliveries_url
    assert_selector "h1", text: "Deliveries"
  end

  test "should create delivery" do
    visit deliveries_url
    click_on "New delivery"

    fill_in "Destination", with: @delivery.destination
    fill_in "Email", with: @delivery.email
    fill_in "First name", with: @delivery.first_name
    fill_in "Height", with: @delivery.height
    fill_in "Last name", with: @delivery.last_name
    fill_in "Length", with: @delivery.length
    fill_in "Middle name", with: @delivery.middle_name
    fill_in "Origin", with: @delivery.origin
    fill_in "Phone number", with: @delivery.phone_number
    fill_in "Weight", with: @delivery.weight
    fill_in "Width", with: @delivery.width
    click_on "Create Delivery"

    assert_text "Delivery was successfully created"
    click_on "Back"
  end

  test "should update Delivery" do
    visit delivery_url(@delivery)
    click_on "Edit this delivery", match: :first

    fill_in "Destination", with: @delivery.destination
    fill_in "Email", with: @delivery.email
    fill_in "First name", with: @delivery.first_name
    fill_in "Height", with: @delivery.height
    fill_in "Last name", with: @delivery.last_name
    fill_in "Length", with: @delivery.length
    fill_in "Middle name", with: @delivery.middle_name
    fill_in "Origin", with: @delivery.origin
    fill_in "Phone number", with: @delivery.phone_number
    fill_in "Weight", with: @delivery.weight
    fill_in "Width", with: @delivery.width
    click_on "Update Delivery"

    assert_text "Delivery was successfully updated"
    click_on "Back"
  end

  test "should destroy Delivery" do
    visit delivery_url(@delivery)
    click_on "Destroy this delivery", match: :first

    assert_text "Delivery was successfully destroyed"
  end
end
