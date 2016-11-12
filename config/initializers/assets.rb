# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(
  activity_feed_timeline.js
  login.css
  graphics.js
  graphics.css
  pos.js
  pos.css
  substrates.js
  substrates.css
  finishes.js
  finishes.css
  graphic_types.js
  graphic_types.css
  sides.js
  sides.css
  milestones.js
  milestones.css
  users.js
  users.css
  widgets.css
  widgets.js
  io_links.css
  io_links.js
)