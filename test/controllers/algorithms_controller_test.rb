require 'test_helper'

class AlgorithmsControllerTest < ActionController::TestCase
  test "should get bruteforce" do
    get :bruteforce
    assert_response :success
  end

  test "should get morissprat" do
    get :morissprat
    assert_response :success
  end

  test "should get shiftor" do
    get :shiftor
    assert_response :success
  end

  test "should get knuthmorissprat" do
    get :knuthmorissprat
    assert_response :success
  end

end
