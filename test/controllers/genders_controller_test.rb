require 'test_helper'

class GendersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gender = genders(:one)
  end

  test "should get index" do
    get genders_url
    assert_response :success
  end

  test "should get new" do
    get new_gender_url
    assert_response :success
  end

  test "should create gender" do
    assert_difference('Gender.count') do
      post genders_url, params: { gender: { name: @gender.name } }
    end

    assert_redirected_to gender_url(Gender.last)
  end

  test "should show gender" do
    get gender_url(@gender)
    assert_response :success
  end

  test "should get edit" do
    get edit_gender_url(@gender)
    assert_response :success
  end

  test "should update gender" do
    patch gender_url(@gender), params: { gender: { name: @gender.name } }
    assert_redirected_to gender_url(@gender)
  end

  test "should destroy gender" do
    assert_difference('Gender.count', -1) do
      delete gender_url(@gender)
    end

    assert_redirected_to genders_url
  end
end
