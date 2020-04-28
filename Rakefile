require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# Fix to be able to use more recent Rake's without havin
# to upgrade rspec
module TempFixForRakeLastComment
  def last_comment
    last_description
  end
end
Rake::Application.send :include, TempFixForRakeLastComment

desc 'Run the spec testing suite'
RSpec::Core::RakeTask.new(:spec)

desc 'Default: run the test suite'
task :default => [:spec]
