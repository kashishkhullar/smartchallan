require 'test_helper'

class Api::V1::CitizenControllerTest < ActionDispatch::IntegrationTest
  test "should get registrations" do
    get api_v1_citizen_registrations_url
    assert_response :success
  end

end
