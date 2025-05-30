source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.10'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
 gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# deviseインストール
gem 'devise'

# 環境変数を管理するためのGem `.env`ファイルに環境変数を保存し、アプリケーション内でこれらの環境変数を簡単に取得
gem 'dotenv-rails'

# MySQLデータベースを利用するためのGem(Gemfile内で`group :production`ブロック内に記述されることで、本番環境でのみこのGemがインストール,使用される)
group :production do
  gem 'mysql2'
end

# SMTPは電子メールの送信を行うためのプロトコルであり、このGemを使用することでRubyプログラムからSMTPサーバーにメールを送信することができます。
gem "net-smtp"
# POPはメールサーバーからメールを取得するためのプロトコルであり、このGemを使用することでRubyプログラムからPOP3サーバーに接続してメールを取得することができます。
gem "net-pop"
# IMAPはメールサーバー上のメールボックスを操作するためのプロトコルであり、このGemを使用することでRubyプログラムからIMAPサーバーに接続してメールボックスを操作することができます。
gem "net-imap"

gem 'kaminari','~> 1.2.1'

#  AWS S3 バケット用
gem 'aws-sdk-s3', require: false