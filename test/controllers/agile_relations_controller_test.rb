require 'test_helper'

class AgileRelationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agile_relation = agile_relations(:one)
  end

  test "should get index" do
    get agile_relations_url
    assert_response :success
  end

  test "should get new" do
    get new_agile_relation_url
    assert_response :success
  end

  test "should create agile_relation" do
    assert_difference('AgileRelation.count') do
      post agile_relations_url, params: { agile_relation: { name: @agile_relation.name } }
    end

    assert_redirected_to agile_relation_url(AgileRelation.last)
  end

  test "should show agile_relation" do
    get agile_relation_url(@agile_relation)
    assert_response :success
  end

  test "should get edit" do
    get edit_agile_relation_url(@agile_relation)
    assert_response :success
  end

  test "should update agile_relation" do
    patch agile_relation_url(@agile_relation), params: { agile_relation: { name: @agile_relation.name } }
    assert_redirected_to agile_relation_url(@agile_relation)
  end

  test "should destroy agile_relation" do
    assert_difference('AgileRelation.count', -1) do
      delete agile_relation_url(@agile_relation)
    end

    assert_redirected_to agile_relations_url
  end
end
