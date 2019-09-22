GOOGLE_OAUTH2_CREDS = Rails.application.config_for(:google_oauth2_creds)

OmniAuth.config.logger = Rails.logger

OmniAuth.config.full_host = 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, GOOGLE_OAUTH2_CREDS["client_id"], GOOGLE_OAUTH2_CREDS["client_secret"],:skip_jwt => true
end