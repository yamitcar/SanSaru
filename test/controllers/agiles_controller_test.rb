require 'test_helper'

class AgilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agile = agiles(:one)
  end

  test "should get index" do
    get agiles_url
    assert_response :success
  end

  test "should get new" do
    get new_agile_url
    assert_response :success
  end

  test "should create agile" do
    assert_difference('Agile.count') do
      post agiles_url, params: { agile: { name: @agile.name } }
    end

    assert_redirected_to agile_url(Agile.last)
  end

  test "should show agile" do
    get agile_url(@agile)
    assert_response :success
  end

  test "should get edit" do
    get edit_agile_url(@agile)
    assert_response :success
  end

  test "should update agile" do
    patch agile_url(@agile), params: { agile: { name: @agile.name } }
    assert_redirected_to agile_url(@agile)
  end

  test "should destroy agile" do
    assert_difference('Agile.count', -1) do
      delete agile_url(@agile)
    end

    assert_redirected_to agiles_url
  end
end
