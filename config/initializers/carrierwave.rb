CarrierWave.configure do |config|
  config.dropbox_app_key = ENV["APP_KEY"]
  config.dropbox_app_secret = ENV["APP_SECRET"]
  config.dropbox_access_token = ENV["ACCESS_TOKEN"]
  config.dropbox_access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  config.dropbox_user_id = ENV["USER_ID"]
  config.dropbox_access_type = "app_folder"
  
   # For testing, upload files to local `tmp` folder.
   config.storage = :dropbox
  # if Rails.env.test? || Rails.env.cucumber?
  #   config.storage = :file
  #   config.enable_processing = false
  #   config.root = "#{Rails.root}/public/uploads"
  # else
  # 	config.storage = :dropbox
  # end
end

