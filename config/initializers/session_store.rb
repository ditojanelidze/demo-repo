redis_host = ENV.fetch('REDIS_HOST', '127.0.0.1')
redis_password = ENV['REDIS_PASSWORD']

# Construct Redis URL with password (if provided)
redis_url = if redis_password.present?
              "rediss://default:#{redis_password}@#{redis_host}"
            else
              "redis://#{redis_host}"
            end

# Final session URL
session_url = "#{redis_url}/0"

# Secure the session cookies if in production
secure = Rails.env.production?

# Session key
key = Rails.env.production? ? "_baitmate_session" : "_baitmate_session_#{Rails.env}"

# Configure Redis session store
Rails.application.config.session_store :redis_store,
                                       servers: [session_url],
                                       expire_after: 30.days,
                                       key:,
                                       threadsafe: true,
                                       secure:
