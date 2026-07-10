class HomeController < ApplicationController
  def show
    @pulse = PreviewPulse.initial
    @rendered_at = Time.current
  end
end
