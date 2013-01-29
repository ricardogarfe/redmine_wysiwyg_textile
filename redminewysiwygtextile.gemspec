Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'redmine_wysiwyg_textile'
  s.version     = "1.0.0.beta"
  s.summary     = 'Redminbe plugin Converter from HTML to Textile and viceversa.'
  s.description = 'Uses html2textile library to convert HTML to Textile and Implements Textile to HTML using Redcloth.'

  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"

  s.author            = 'Ricardo García Fernández'
  s.email             = 'ricardogarfe@gmail.com'
  s.homepage          = 'http://ricardogarfe.github.com/redmine_wysiwyg_textile'

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.require_path = 'lib'
  s.files        = Dir.glob("{lib}/**/*") + %w(example.rb README.mdown)

  s.add_development_dependency('rake', "~> 0.9")
# s.add_development_dependency('html2textile', "~> 1.0.0.beta2")
  s.add_development_dependency('RedCloth', "~> 4.2")
  s.add_development_dependency('test-unit', "~> 2.5.4")

end
