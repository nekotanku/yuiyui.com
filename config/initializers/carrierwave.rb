CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'],
  }
  case Rails.env
    when 'production'
      config.fog_directory = 's3-yuiyuicom'

    when 'development'
      config.fog_directory = 'dev-s3-yuiyuicom'

    when 'test'
      config.fog_directory = 'dev-s3-yuiyuicom'
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
