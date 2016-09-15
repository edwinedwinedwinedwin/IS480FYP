# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( component.css )
Rails.application.config.assets.precompile += %w( flickity/flickity.css )
Rails.application.config.assets.precompile += %w( _bootstrap-custom.scss )
#Rails.application.config.assets.precompile += %w( jquery.bxslider.css )
Rails.application.config.assets.precompile += %w( userpage.css )
Rails.application.config.assets.precompile += %w( jquery.dataTables.min.css )
Rails.application.config.assets.precompile += %w( responsive.dataTables.min.css )
