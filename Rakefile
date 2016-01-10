require 'rake/testtask'
require_relative 'lib/tarot/tasks'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

namespace :moon do
  desc "Build a CSV of moon phase data for the current year"
  task :seed do
    Tarot::Tasks::SeedMoonData.new.run
  end
end
