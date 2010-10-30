# coding: utf-8

require "rake"
require "rspec/core/rake_task"

task :default => [:spec]

desc "spec all"
RSpec::Core::RakeTask.new do |t|
  t.name = "spec"
  t.pattern = "spec/*_spec.rb"
end

desc "run sample"
task :run do
  sh "ruby sample.rb"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "automaze"
    gemspec.summary = "maze generator"
    gemspec.email = "toshi.hirooka@gmail.com"
    gemspec.homepage = "http://github.com/tosik/automazerb"
    gemspec.description = "maze generator"
    gemspec.authors = ["Toshiyuki Hirooka"]

    gemspec.add_dependency("activesupport", ">= 3.0.1")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


