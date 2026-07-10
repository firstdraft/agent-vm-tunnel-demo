require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "renders HTTP and WebSocket diagnostics with hardened headers" do
    get root_path

    assert_response :success
    assert_select "h1", "Live preview smoke test"
    assert_select "turbo-cable-stream-source", count: 1
    assert_select "form[action=?][method=post]", pulse_path
    assert_equal "no-store", response.headers["Cache-Control"]
    assert_equal "DENY", response.headers["X-Frame-Options"]
    assert_equal "no-referrer", response.headers["Referrer-Policy"]
    assert_includes response.headers.fetch("Content-Security-Policy"), "default-src 'self'"
  end

  test "framework boot check is reachable" do
    get rails_health_check_path

    assert_response :success
  end
end
