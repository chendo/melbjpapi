$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'web'

run Sinatra::Application
