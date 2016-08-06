CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAJTLNEP6IBMKQDKFQ",
      :aws_secret_access_key  => "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",
      :region                 => 'ap-southeast-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = 'ybcouploads'  
end