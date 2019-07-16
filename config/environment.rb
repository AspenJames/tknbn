# typed: false
require 'bundler'
require 'require_all'
require 'sinatra/activerecord'
require 'sorbet-runtime'

require_all 'lib'


ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3',
	:database => 'db/tknbn-dev.sqlite3'
)

ActiveRecord::Base.logger = Logger.new(STDOUT)
