require 'serverspec'

# Required by serverspec
set :backend, :exec

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require_relative(file) }
