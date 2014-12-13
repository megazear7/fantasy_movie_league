require 'test_helper'

class SeasonRequestsControllerTest < ActionController::TestCase
  setup do
    @season_request = season_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:season_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create season_request" do
    assert_difference('SeasonRequest.count') do
      post :create, season_request: {  }
    end

    assert_redirected_to season_request_path(assigns(:season_request))
  end

  test "should show season_request" do
    get :show, id: @season_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @season_request
    assert_response :success
  end

  test "should update season_request" do
    patch :update, id: @season_request, season_request: {  }
    assert_redirected_to season_request_path(assigns(:season_request))
  end

  test "should destroy season_request" do
    assert_difference('SeasonRequest.count', -1) do
      delete :destroy, id: @season_request
    end

    assert_redirected_to season_requests_path
  end
end
