require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should get show" do
    get orders_show_url
    assert_response :success
  end
>>>>>>> dd15788b71666d8dcb0e94ad6f6e23a297663825
end
