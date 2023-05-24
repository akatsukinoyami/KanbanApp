source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false        # Reduces boot times through caching; required in config/boot.rb
gem "bootstrap", "~> 5.2"
gem "cssbundling-rails"               # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "devise", "~> 4.9"
gem "jbuilder"                        # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jsbundling-rails"                # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "nokogiri", force_ruby_platform: true
gem "haml-rails", "~> 2.0"
gem "pg", "~> 1.1"                    # Use postgresql as the database for Active Record
gem "puma", "~> 5.0"                  # Use the Puma web server [https://github.com/puma/puma]
gem "rails", "~> 7.0.4", ">= 7.0.4.3" # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "sprockets-rails"                 # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "stimulus-rails"                  # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "turbo-rails"                     # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "tzinfo-data"

# gem "bcrypt", "~> 3.1.7"            # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "image_processing", "~> 1.2"    # Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "kredis"                        # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "redis", "~> 4.0"               # Use Redis adapter to run Action Cable in production
# gem "sassc-rails"                   # Use Sass to process CSS

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ] # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "rspec", "~> 3.12"
end

group :development do
  gem "html2haml", "~> 2.3"
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]
end
