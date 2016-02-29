require 'test_helper'

class HostRulesControllerTest < ActionController::TestCase
  setup do
    @host_rule = host_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:host_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create host_rule" do
    assert_difference('HostRule.count') do
      post :create, host_rule: { excluded: @host_rule.excluded, host: @host_rule.host, include_sub: @host_rule.include_sub, ord: @host_rule.ord, port: @host_rule.port }
    end

    assert_redirected_to host_rule_path(assigns(:host_rule))
  end

  test "should show host_rule" do
    get :show, id: @host_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @host_rule
    assert_response :success
  end

  test "should update host_rule" do
    patch :update, id: @host_rule, host_rule: { excluded: @host_rule.excluded, host: @host_rule.host, include_sub: @host_rule.include_sub, ord: @host_rule.ord, port: @host_rule.port }
    assert_redirected_to host_rule_path(assigns(:host_rule))
  end

  test "should destroy host_rule" do
    assert_difference('HostRule.count', -1) do
      delete :destroy, id: @host_rule
    end

    assert_redirected_to host_rules_path
  end
end
