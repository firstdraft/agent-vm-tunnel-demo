class PreviewPulse
  STREAM = "preview-pulse"

  attr_reader :id, :sent_at

  def self.initial
    new(id: "waiting", sent_at: nil)
  end

  def self.now
    new(id: SecureRandom.hex(6), sent_at: Time.current)
  end

  def initialize(id:, sent_at:)
    @id = id
    @sent_at = sent_at
  end

  def sent?
    sent_at.present?
  end
end
