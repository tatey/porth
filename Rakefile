begin
  require 'bundler'
rescue LoadError
  raise "Could not load the bundler gem. Install it with `gem install bundler`."
end

begin
  Bundler.setup
rescue Bundler::GemNotFound
  raise RuntimeError, "Bundler couldn't find some gems. Did you run `bundle install`?"
end

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new :test do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*_test.rb'
end

task :default => :test
