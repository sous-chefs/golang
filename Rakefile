#!/usr/bin/env rake

require 'foodcritic'
require 'rake/testtask'
require 'tailor/rake_task'

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end

task :default => :foodcritic

task :lint => [:tailor, :foodcritic]
task :default => [:lint]

# FC043 is excluded because of the problem described in https://github.com/NOX73/chef-golang/issues/3
FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'], :tags => ['~FC043'] }
end

Tailor::RakeTask.new