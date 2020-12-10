
source "https://rubygems.org"
ruby '2.7.0'

gem "nokogiri"
gem "open-uri"
gem 'lolize'
gem 'thin'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '~> 1.4'
  gem 'pry'
end

group :production do
  gem 'pg'
end
