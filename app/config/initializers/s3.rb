CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAIQNXC56XKQD6X4KQ",
      :aws_secret_access_key  => "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",
      :region                 => 'ap-southeast-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = 'ybcoupload'  
end