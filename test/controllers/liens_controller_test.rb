require 'test_helper'

class LiensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lien = liens(:one)
  end

  test "should get index" do
    get liens_url
    assert_response :success
  end

  test "should get new" do
    get new_lien_url
    assert_response :success
  end

  test "should create lien" do
    assert_difference('Lien.count') do
      post liens_url, params: { lien: { name: @lien.name, url: @lien.url } }
    end

    assert_redirected_to lien_url(Lien.last)
  end

  test "should show lien" do
    get lien_url(@lien)
    assert_response :success
  end

  test "should get edit" do
    get edit_lien_url(@lien)
    assert_response :success
  end

  test "should update lien" do
    patch lien_url(@lien), params: { lien: { name: @lien.name, url: @lien.url } }
    assert_redirected_to lien_url(@lien)
  end

  test "should destroy lien" do
    assert_difference('Lien.count', -1) do
      delete lien_url(@lien)
    end

    assert_redirected_to liens_url
  end
end
