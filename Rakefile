require 'rake'
require 'rake/testtask'

desc 'Run unit tests'
task :test do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/test*.rb']
    t.verbose = true
  end
end

task :default => :test

desc 'Runs the server'
task :run do
  ruby "server.rb"
end
