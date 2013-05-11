# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "oriental"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Greg Leppert"]
  s.date = "2013-05-08"
  s.description = "Tools for OrientDB"
  s.email = ["greg@formasfunction.com"]
  s.files = [".gitignore", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "lib/oriental.rb", "lib/oriental/version.rb", "oriental.gemspec"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Tools for OrientDB"

  s.add_dependency("orientdb4r")

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
