class AvaterUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  if Rails.env.production? || Rails.env.staging?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def size_range
    1..5.megabytes
  end

  version :thumb do
    process resize_to_fit: [200, 200]
  end
  version :thumb50 do
    process resize_to_fit: [100, 100]
  end

  def default_url
  "default.jpg"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
     "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  # 一意となるトークンを作成
  protected
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end
