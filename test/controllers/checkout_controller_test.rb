require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get checkout_new_url
    assert_response :success
  end

  test "should get create" do
    get checkout_create_url
    assert_response :success
  end
<<<<<<< HEAD

  test "should get index" do
    get checkout_index_url
    assert_response :success
  end
=======
>>>>>>> dd15788b71666d8dcb0e94ad6f6e23a297663825
end
