# Components we want to test
gem 'rails_12factor'
gem 'rails_migrate_mutex'
gem 'puma'
gem 'sidekiq'

# Ensure that gems with C lib dependencies work
gem 'sqlite3'
gem 'pg'
gem 'nokogiri'
gem 'sassc'

# Ensure that git works
gem 'currencies', git: 'https://github.com/hexorx/currencies.git', tag: 'v0.4.3'

# Test action
route 'root "test#index"'
