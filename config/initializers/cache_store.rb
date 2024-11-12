redis_host = ENV.fetch('REDIS_HOST', '127.0.0.1')
redis_password = ENV['REDIS_PASSWORD']

# Construct Redis URL with password (if provided)
redis_url = if redis_password.present?
              "redis://:#{redis_password}@#{redis_host}"
            else
              "redis://#{redis_host}"
            end

# Final session URL
cache_url = "#{redis_url}/1"

# Configure Redis session store
Rails.application.config.cache_store = :redis_cache_store, {url: cache_url}, {expires_in: 10.days}
