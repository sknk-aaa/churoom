source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "puma", ">= 5.0"
gem "importmap-rails"
#gem "turbo-rails"
gem "stimulus-rails"


# ---- DB は環境別に分ける：本番=PostgreSQL ----
group :development, :test do
  gem "sqlite3", "~> 2.7"
end
group :production do
  gem "pg", ">= 1.5"
end

# 起動高速化
gem "bootsnap", require: false


# .env は開発だけで使う（本番は環境変数で管理）
group :development, :test do
  gem "dotenv-rails"
end

# Windows/JRuby 限定
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
