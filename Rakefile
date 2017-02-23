require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test

RDoc::Task.new :docs do |rdoc|
  rdoc.rdoc_files.include("lib/html.rb")
  rdoc.rdoc_dir = "docs"
end
