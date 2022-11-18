# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "url-shortener"
  spec.version = "1.0.0"
  spec.authors = ["Botond Orban"]
  spec.email = ["orbanbotond@gmail.com"]
  spec.require_paths = ["lib"]
  spec.files = Dir["lib/**/*"]
  spec.summary = "Url Shortener Main Algorythm"

  spec.add_dependency 'rom-sql'
  spec.add_dependency 'pg'
  spec.add_dependency 'rake'
  spec.add_dependency 'dotenv-rails'
  spec.add_dependency 'erb'
end
