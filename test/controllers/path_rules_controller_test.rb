require 'test_helper'

class PathRulesControllerTest < ActionController::TestCase
  setup do
    @path_rule = path_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:path_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create path_rule" do
    assert_difference('PathRule.count') do
      post :create, path_rule: { content_css_paths: @path_rule.content_css_paths, excluded: @path_rule.excluded, host_url_id: @path_rule.host_url_id, ord: @path_rule.ord, path_pattern: @path_rule.path_pattern, title_css_path: @path_rule.title_css_path }
    end

    assert_redirected_to path_rule_path(assigns(:path_rule))
  end

  test "should show path_rule" do
    get :show, id: @path_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @path_rule
    assert_response :success
  end

  test "should update path_rule" do
    patch :update, id: @path_rule, path_rule: { content_css_paths: @path_rule.content_css_paths, excluded: @path_rule.excluded, host_url_id: @path_rule.host_url_id, ord: @path_rule.ord, path_pattern: @path_rule.path_pattern, title_css_path: @path_rule.title_css_path }
    assert_redirected_to path_rule_path(assigns(:path_rule))
  end

  test "should destroy path_rule" do
    assert_difference('PathRule.count', -1) do
      delete :destroy, id: @path_rule
    end

    assert_redirected_to path_rules_path
  end
end
