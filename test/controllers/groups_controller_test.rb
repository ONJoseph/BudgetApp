require "test_helper"
require 'rails_helper'


class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get groups_new_url
    assert_response :success
  end

  test "should get create" do
    get groups_create_url
    assert_response :success
  end

  test "should get show" do
    get groups_show_url
    assert_response :success
  end
end
