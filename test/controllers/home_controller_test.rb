require 'test_helper'
require 'rails_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get welcome_new_url
    assert_response :success
  end

  test 'should get create' do
    get welcome_create_url
    assert_response :success
  end

  test 'should get index' do
    get welcome_index_url
    assert_response :success
  end
end
