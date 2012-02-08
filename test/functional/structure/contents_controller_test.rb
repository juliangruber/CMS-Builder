require 'test_helper'

class Structure::ContentsControllerTest < ActionController::TestCase
  setup do
    @structure_content = structure_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:structure_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create structure_content" do
    assert_difference('Structure::Content.count') do
      post :create, structure_content: @structure_content.attributes
    end

    assert_redirected_to structure_content_path(assigns(:structure_content))
  end

  test "should show structure_content" do
    get :show, id: @structure_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @structure_content
    assert_response :success
  end

  test "should update structure_content" do
    put :update, id: @structure_content, structure_content: @structure_content.attributes
    assert_redirected_to structure_content_path(assigns(:structure_content))
  end

  test "should destroy structure_content" do
    assert_difference('Structure::Content.count', -1) do
      delete :destroy, id: @structure_content
    end

    assert_redirected_to structure_contents_path
  end
end
