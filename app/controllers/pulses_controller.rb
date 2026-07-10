class PulsesController < ApplicationController
  MAX_REQUEST_BYTES = 1.kilobyte
  RATE_LIMIT = 6
  RATE_WINDOW = 1.minute

  before_action :reject_oversized_request
  rate_limit to: RATE_LIMIT, within: RATE_WINDOW, with: :rate_limited

  def create
    pulse = PreviewPulse.now
    Turbo::StreamsChannel.broadcast_replace_to(
      PreviewPulse::STREAM,
      target: "live_status",
      partial: "home/live_status",
      locals: { pulse: pulse }
    )

    head :no_content
  end

  private
    def reject_oversized_request
      head 413 if request.content_length.to_i > MAX_REQUEST_BYTES
    end

    def rate_limited
      response.set_header("Retry-After", RATE_WINDOW.to_i.to_s)
      head :too_many_requests
    end
end
