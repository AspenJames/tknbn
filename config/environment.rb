# typed: false
require 'bundler/setup'
require 'require_all'
require 'sinatra/activerecord'
require 'sorbet-runtime'
require 'curses'

require_all 'lib'

def db_env
  ENV['SINATRA_ENV'] ||= 'dev'
end

ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3',
	:database => "db/tknbn-#{db_env}.sqlite3"
)

ActiveRecord::Base.logger = nil
