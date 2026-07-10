require "test_helper"

class PreviewPulseTest < ActiveSupport::TestCase
  test "initial pulse is inert" do
    pulse = PreviewPulse.initial

    assert_not pulse.sent?
    assert_nil pulse.sent_at
  end

  test "new pulses have distinct identifiers and timestamps" do
    first = PreviewPulse.now
    second = PreviewPulse.now

    assert_predicate first, :sent?
    assert_instance_of ActiveSupport::TimeWithZone, first.sent_at
    assert_not_equal first.id, second.id
  end
end
