require 'rake/testtask'
require_relative 'lib/tarot/tasks'
require_relative 'lib/tarot/services'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

desc "Load gem and drop into console"
task :console do
  `irb -I lib/ -r ~/programming/tarot/tarot_backend/lib/tarot.rb`
end

namespace :moon do
  desc "Build a CSV of moon phase data for the current year"
  task :seed do
    Tarot::Tasks::SeedMoonData.new.run
  end

  desc "Get moon info for today"
  task :info do
    info = Tarot::Services::MoonInfo.new
    pattern = info.waxing? ? 'growing' : 'shrinking'

    p "Luna is #{(info.illumination * 100).floor}% illuminated "\
      "and #{pattern} (#{info.phase})."
    p "Active elements are: #{info.active_elements.join(" and ")}"
  end
end
