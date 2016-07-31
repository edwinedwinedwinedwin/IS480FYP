Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(ENV['AKIAIJVKHHNVYQ3VWZCQ'], ENV['sxw7YpcyOQuUbiu3kP7jCnHyfbIZwVGOL9IBAE']),
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])