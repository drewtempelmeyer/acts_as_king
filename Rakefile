require 'bundler'
require 'rake/testtask'
require 'hanna/rdoctask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

Rake::RDocTask.new(:rdoc) do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rd.options << "--all"
end

task :default => :test

