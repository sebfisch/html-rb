Gem::Specification.new do |s|
  s.name        = 'html'
  s.version     = '0.1.3'
  s.date        = '2017-02-24'
  s.summary     = 'HTML in Ruby with Blocks'
  s.description = 'Simple HTML creating language'
  s.author      = 'Sebastian Fischer'
  s.email       = 'mail@sebfisch.de'
  s.files       = ['lib/html.rb']
  s.homepage    = 'http://rubygems.org/gems/html'
  s.license     = 'MIT'
  s.add_runtime_dependency 'htmlentities', '~> 4.3'
end
