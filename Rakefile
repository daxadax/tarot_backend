require 'rake/testtask'
require_relative 'lib/tarot/tasks'
require_relative 'lib/tarot/services'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

desc 'drop into console'
task :console do
  sh "irb -r './lib/tarot'"
end
