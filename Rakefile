#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec/core/rake_task'

desc 'Default: Run specs.'
task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = "--format doc"
end
