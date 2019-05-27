require "bundler/gem_tasks"
require "rspec/core/rake_task"
require_relative 'config/environment'
require 'sinatra/activerecord/rake'
include ActiveRecord::Tasks

task :environment do
  require_relative 'config/environment'
end

desc 'test the board'
task :board do
	board = Board.new()
	board.run
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
