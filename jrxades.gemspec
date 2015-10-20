# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jrxades/version'
platform = "java"

Gem::Specification.new do |spec|
  spec.name          = "jrxades"
  spec.version       = Jrxades::VERSION
  spec.authors       = ["Jose Carrion"]
  spec.email         = ["joseloc@gmail.com"]
  spec.summary       = %q{Jrxades es una gema JRuby que permite firmar un documento xml con un certificado .p12}
  spec.description   = %q{Jrxades es una gema JRuby que permite firmar un documento xml con un certificado .p12, Esta gema ha sido creada para la Facturación Electrónica que se usa en Ecuador, sin embargo se basa en las especificaciones definidas en XADES_BES lo que permitiría ser usada en otros ambientes que requieran XADES_BES.}
  spec.homepage      = "https://github.com/joselo/jrxades"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 0'
end
