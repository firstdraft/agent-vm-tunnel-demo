require "test_helper"

class HealthControllerTest < ActionDispatch::IntegrationTest
  test "returns a small no-store JSON health document" do
    get health_path

    assert_response :success
    assert_equal "application/json", response.media_type
    assert_equal "no-store", response.headers["Cache-Control"]

    body = response.parsed_body
    assert_equal "ok", body.fetch("status")
    assert_equal "agent-vm-tunnel-demo", body.fetch("service")
    assert_equal "/cable", body.fetch("websocket_path")
    assert_predicate body.fetch("boot_id"), :present?
    assert_nothing_raised { Time.iso8601(body.fetch("time")) }
  end
end
