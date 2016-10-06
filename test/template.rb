# frozen_string_literal: true
# Components we want to test
gem 'rails_migrate_mutex'
gem 'puma'
gem 'rack-timeout'
gem 'sidekiq'
gem 'clockwork'

# Ensure that gems with C lib dependencies work
gem 'sqlite3'
gem 'pg'
gem 'mysql2'
gem 'nokogiri'
gem 'sassc'

# Ensure that git works
gem 'currencies', git: 'https://github.com/hexorx/currencies.git', tag: 'v0.4.3'

# Ensure that vendored gems work
gem 'vendor-gem', path: './vendor/vendor-gem'

# Test action
route 'root "test#index"'
