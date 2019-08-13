CarrierWave.configure do |config|
  config.storage    =  :aws
  config.aws_bucket = "happyshop-numpon"
  config.aws_acl    =  :public_read

  config.aws_credentials = {
      access_key_id: ENV["S3_ACCESS_KEY"],
      secret_access_key: ENV["S3_SECRET_KEY"]
  }
end