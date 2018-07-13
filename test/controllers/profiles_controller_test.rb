require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
  end

  test 'should get index' do
    get profiles_url
    assert_response :success
  end

  test 'should get new' do
    get new_profile_url
    assert_response :success
  end

  test 'should create profile' do
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { agileRelation_id: @profile.agileRelation_id,
                                              agile_description: @profile.agile_description, agile_id: @profile.agile_id,
                                              bio: @profile.bio, bring: @profile.bring, expectancy: @profile.expectancy,
                                              first_time: @profile.first_time, gender_id: @profile.gender_id,
                                              hobbies: @profile.hobbies, proposal: @profile.proposal,
                                              residence: @profile.residence, size_id: @profile.size_id } }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test 'should show profile' do
    get profile_url(@profile)
    assert_response :success
  end

  test 'should get edit' do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test 'should update profile' do
    patch profile_url(@profile), params: { profile: { agileRelation_id: @profile.agileRelation_id,
                                                      agile_description: @profile.agile_description,
                                                      agile_id: @profile.agile_id, bio: @profile.bio,
                                                      bring: @profile.bring, expectancy: @profile.expectancy,
                                                      first_time: @profile.first_time, gender_id: @profile.gender_id,
                                                      hobbies: @profile.hobbies, proposal: @profile.proposal,
                                                      residence: @profile.residence, size_id: @profile.size_id } }
    assert_redirected_to profile_url(@profile)
  end

  test 'should destroy profile' do
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
