class HealthController < ApplicationController
  def show
    render json: {
      status: "ok",
      service: "agent-vm-tunnel-demo",
      boot_id: Rails.application.config.x.demo.boot_id,
      time: Time.current.iso8601(6),
      websocket_path: "/cable"
    }
  end
end
