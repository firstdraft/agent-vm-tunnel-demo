require "test_helper"

class ActionCableSecurityTest < ActiveSupport::TestCase
  test "uses exact same-origin validation without wildcard exceptions" do
    cable = ActionCable.server.config

    assert cable.allow_same_origin_as_host
    assert_empty Array(cable.allowed_request_origins)
    assert_not cable.disable_request_forgery_protection
  end
end
