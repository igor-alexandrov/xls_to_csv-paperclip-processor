require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name = "xls_to_csv-paperclip-processor"
    gem.homepage = "http://github.com/igor-alexandrov/xls_to_csv-paperclip-processor"
    gem.license = "MIT"
    gem.summary = %Q{Gem for easy convertation .xls to .csv with Paperclip}
    gem.description = %Q{If you want to convert .xls to .csv simply and unwittingly, then this gem is for you!}
    gem.email = "igor.alexandrov@gmail.com"
    gem.authors = ["Igor Alexandrov"]
    gem.add_dependency 'paperclip', '>=2.3.0'
    gem.add_development_dependency "rspec", ">= 0"
    gem.add_development_dependency "yard", ">= 0"
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
  

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
