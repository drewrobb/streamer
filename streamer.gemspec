# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "code_buddy/version"

Gem::Specification.new do |s|
  s.name = %q{streamer}
  s.version = CodeBuddy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Drew Robb"]
  s.date = %q{2011-02-02}
  s.description = %q{Stream data to user.}
  s.email = %q{drewrobb@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc", "lib/streamer.rb"]
  #s.files = ["LICENSE", "README.rdoc", "Rakefile", "lib/streamer.rb", "streamer.gemspec"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage = %q{http://github.com/drewrobb/streamer}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Streamer", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{streamer}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Stream data to user.}

  s.add_dependency             'rails', '~> 3.0.0'
  s.add_development_dependency 'rake',  '~> 0.8.7'
  s.add_development_dependency 'rspec', '~> 2.5.0'
  s.add_development_dependency 'mocha', '~> 0.9.11'

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
