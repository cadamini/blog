CarrierWave.configure do |config|
  config.dropbox_access_token = ENV["ACCESS_TOKEN"]
  config.storage = :dropbox
end

# local tests
# if Rails.env.test? || Rails.env.cucumber?
#   config.storage = :file
#   config.enable_processing = false
#   config.root = "#{Rails.root}/public/uploads"
# else
#   config.storage = :dropbox
# end
