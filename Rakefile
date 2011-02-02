# Rakefile
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('streamer', '0.1.0') do |p|
  p.description    = "Stream data to user."
  p.url            = "http://github.com/drewrobb/streamer"
  p.author         = "Drew Robb"
  p.email          = "drewrobb@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
