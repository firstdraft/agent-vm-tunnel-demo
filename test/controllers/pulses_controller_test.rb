require "test_helper"
require "action_cable/test_helper"

class PulsesControllerTest < ActionDispatch::IntegrationTest
  include ActionCable::TestHelper

  setup do
    Rails.cache.clear
  end

  test "broadcasts a replace operation without accepting user content" do
    broadcasts = capture_broadcasts(PreviewPulse::STREAM) do
      post pulse_path
    end

    assert_response :no_content
    assert_equal 1, broadcasts.size
    assert_includes broadcasts.first, '<turbo-stream action="replace" target="live_status">'
    assert_includes broadcasts.first, "WebSocket pulse received"
  end

  test "rejects oversized request bodies before broadcasting" do
    assert_no_broadcasts PreviewPulse::STREAM do
      post pulse_path,
        params: "x" * (PulsesController::MAX_REQUEST_BYTES + 1),
        headers: { "CONTENT_TYPE" => "text/plain" }
    end

    assert_response 413
  end

  test "rate limits repeated pulses by client address" do
    PulsesController::RATE_LIMIT.times do
      post pulse_path
      assert_response :no_content
    end

    post pulse_path

    assert_response :too_many_requests
    assert_equal PulsesController::RATE_WINDOW.to_i.to_s, response.headers["Retry-After"]
  end
end
