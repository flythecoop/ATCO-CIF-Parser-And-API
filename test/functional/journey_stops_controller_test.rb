require 'test_helper'

class JourneyStopsControllerTest < ActionController::TestCase
  setup do
    @journey_stop = journey_stops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:journey_stops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create journey_stop" do
    assert_difference('JourneyStop.count') do
      post :create, :journey_stop => @journey_stop.attributes
    end

    assert_redirected_to journey_stop_path(assigns(:journey_stop))
  end

  test "should show journey_stop" do
    get :show, :id => @journey_stop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @journey_stop.to_param
    assert_response :success
  end

  test "should update journey_stop" do
    put :update, :id => @journey_stop.to_param, :journey_stop => @journey_stop.attributes
    assert_redirected_to journey_stop_path(assigns(:journey_stop))
  end

  test "should destroy journey_stop" do
    assert_difference('JourneyStop.count', -1) do
      delete :destroy, :id => @journey_stop.to_param
    end

    assert_redirected_to journey_stops_path
  end
end
