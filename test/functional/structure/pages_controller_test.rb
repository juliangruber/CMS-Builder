require 'test_helper'

class Structure::PagesControllerTest < ActionController::TestCase
  setup do
    @structure_page = structure_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:structure_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create structure_page" do
    assert_difference('Structure::Page.count') do
      post :create, structure_page: @structure_page.attributes
    end

    assert_redirected_to structure_page_path(assigns(:structure_page))
  end

  test "should show structure_page" do
    get :show, id: @structure_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @structure_page
    assert_response :success
  end

  test "should update structure_page" do
    put :update, id: @structure_page, structure_page: @structure_page.attributes
    assert_redirected_to structure_page_path(assigns(:structure_page))
  end

  test "should destroy structure_page" do
    assert_difference('Structure::Page.count', -1) do
      delete :destroy, id: @structure_page
    end

    assert_redirected_to structure_pages_path
  end
end
