#!/usr/bin/env rake

require 'foodcritic'
require 'rspec/core/rake_task'
require 'tailor/rake_task'

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end

task :default => [:version, :tailor, :foodcritic, :spec]

task :version do
  IO.write('version.txt', (ENV['BUILD_NUMBER'] ? "0.0.#{ENV['BUILD_NUMBER']}" : '0.0.1'))
end

# FC043 is excluded because of the problem described in https://github.com/NOX73/chef-golang/issues/3
FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'], :tags => ['~FC043'] }
end

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.rspec_opts = ['--color', '-f documentation', '-tunit']
end

Tailor::RakeTask.new