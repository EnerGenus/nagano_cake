# -*- encoding: utf-8 -*-
# stub: actionpack 6.1.7.10 ruby lib

Gem::Specification.new do |s|
  s.name = "actionpack".freeze
  s.version = "6.1.7.10".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/rails/rails/issues", "changelog_uri" => "https://github.com/rails/rails/blob/v6.1.7.10/actionpack/CHANGELOG.md", "documentation_uri" => "https://api.rubyonrails.org/v6.1.7.10/", "mailing_list_uri" => "https://discuss.rubyonrails.org/c/rubyonrails-talk", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/rails/rails/tree/v6.1.7.10/actionpack" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2024-10-23"
  s.description = "Web apps on Rails. Simple, battle-tested conventions for building and testing MVC web applications. Works with any Rack-compatible server.".freeze
  s.email = "david@loudthinking.com".freeze
  s.homepage = "https://rubyonrails.org".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.requirements = ["none".freeze]
  s.rubygems_version = "3.5.16".freeze
  s.summary = "Web-flow and rendering framework putting the VC in MVC (part of Rails).".freeze

  s.installed_by_version = "3.6.5".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, ["= 6.1.7.10".freeze])
  s.add_runtime_dependency(%q<rack>.freeze, ["~> 2.0".freeze, ">= 2.0.9".freeze])
  s.add_runtime_dependency(%q<rack-test>.freeze, [">= 0.6.3".freeze])
  s.add_runtime_dependency(%q<rails-html-sanitizer>.freeze, ["~> 1.0".freeze, ">= 1.2.0".freeze])
  s.add_runtime_dependency(%q<rails-dom-testing>.freeze, ["~> 2.0".freeze])
  s.add_runtime_dependency(%q<actionview>.freeze, ["= 6.1.7.10".freeze])
  s.add_development_dependency(%q<activemodel>.freeze, ["= 6.1.7.10".freeze])
end
