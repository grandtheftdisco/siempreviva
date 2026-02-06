require 'base64'
require 'time'
require 'cloudinary'
require 'dotenv'
Dotenv.load('.env.development.local')

Cloudinary.config_from_url("cloudinary://#{ENV['CLOUDINARY_API_KEY']}:#{ENV['CLOUDINARY_API_SECRET']}@siempreviva")
Cloudinary.config do |config|
  config.secure = true
end