require "bundler/gem_tasks"
require "rspec/core/rake_task"
require_relative 'config/environment'
require 'sinatra/activerecord/rake'
require 'pry'
include ActiveRecord::Tasks

task :environment do
  require_relative 'config/environment'
end

desc "Run an interactive console"
task :console do
	Pry.start
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
