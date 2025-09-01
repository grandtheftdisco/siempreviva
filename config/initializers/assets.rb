# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_pathweb: bin/rails server -p 3000 -b 0.0.0.0
Rails.application.config.assets.paths << Rails.root.join("public/assets")
Rails.application.config.assets.precompile += %w( tailwind/email.css )