Rails.application.config.x.demo.boot_id = ENV.fetch("APP_REVISION") { SecureRandom.hex(6) }
