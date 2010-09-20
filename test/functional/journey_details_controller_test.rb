require 'test_helper'

class JourneyDetailsControllerTest < ActionController::TestCase
  setup do
    @journey_detail = journey_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:journey_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create journey_detail" do
    assert_difference('JourneyDetail.count') do
      post :create, :journey_detail => @journey_detail.attributes
    end

    assert_redirected_to journey_detail_path(assigns(:journey_detail))
  end

  test "should show journey_detail" do
    get :show, :id => @journey_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @journey_detail.to_param
    assert_response :success
  end

  test "should update journey_detail" do
    put :update, :id => @journey_detail.to_param, :journey_detail => @journey_detail.attributes
    assert_redirected_to journey_detail_path(assigns(:journey_detail))
  end

  test "should destroy journey_detail" do
    assert_difference('JourneyDetail.count', -1) do
      delete :destroy, :id => @journey_detail.to_param
    end

    assert_redirected_to journey_details_path
  end
end
