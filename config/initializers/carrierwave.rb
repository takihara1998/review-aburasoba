require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production? # 本番環境の場合はS3へアップロード
  CarrierWave.configure do |config|
    # config.storage :fog
    config.fog_provider = 'fog/aws'
    # config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_IAM_ACCESS_KEY_ID'], # アクセスキー
      aws_secret_access_key: ENV['AWS_IAM_SECRET_ACCESS_KEY'], # シークレットアクセスキー
      region: ENV['AWS_S3_REGION'], # リージョン
      # path_style: true
    }
    config.fog_directory  = ENV['AWS_S3_BUCKET'] # バケット名
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
  # else # 本番環境以外の場合はアプリケーション内にアップロード
  #   config.storage :file
  #   config.enable_processing = false if Rails.env.test?
  # end
  # 日本語ファイル名の設定
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end