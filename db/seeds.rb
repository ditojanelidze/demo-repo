# Load environment-specific seeds
env_seed_file = Rails.root.join('db', 'seeds', "#{Rails.env}.rb")

if File.exist?(env_seed_file)
  puts "Loading #{Rails.env} seeds..."
  load(env_seed_file)
else
  puts "No seeds file found for #{Rails.env} environment."
end
