require File.expand_path('../config/environment', __FILE__)

if ENV['RACK_ENV'] == 'development'
    puts 'Loading NewRelic in developer mode ...'
    # require 'new_relic/rack/developer_mode'
    # use NewRelic::Rack::DeveloperMode
    # Serve any requests to the root path ('/') with public/index.html.
end

use Rack::Config do |env|
    env['api.tilt.root'] = File.expand_path('views')
end

# NewRelic::Agent.manual_start

run SalesOn::App.instance
