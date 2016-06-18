source 'https://rubygems.org'
ruby '2.2.3'

gem 'grape', '~> 0.16.2'
gem 'grape-entity', '~> 0.5.1'
gem 'sequel'
gem 'thin'
gem 'oj'
gem 'erubis'

group :development do
    gem 'rake'
    gem 'pry'
end

group :test do
    gem 'fabrication'
    gem 'fuubar'
    gem 'rspec'
    gem 'rspec-mocks'
    gem 'rack-test'
    gem 'simplecov', '~> 0.7.1'
    gem 'simplecov-rcov'
end

group :test, :development do
    gem 'sqlite3'
    gem 'coveralls', require: false
end
