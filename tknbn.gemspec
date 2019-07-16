
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tknbn/version"

Gem::Specification.new do |spec|
  spec.name          = "tknbn"
  spec.version       = Tknbn::VERSION
  spec.authors       = ["Aspen James"]
  spec.email         = ["aspenjames@tqca.org"]

  spec.summary       = %q{Curses-based kanban board}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/AspenJames/tknbn"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/AspenJames/tknbn"
    spec.metadata["changelog_uri"] = "https://github.com/AspenJames/tknbn"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.require_paths = ["lib", Dir.glob('lib/**/*')]

	spec.add_runtime_dependency "require_all", "~> 2.0"
	spec.add_runtime_dependency "curses", "~> 1.3"
	spec.add_runtime_dependency "sinatra-activerecord", "~> 2.0"
	spec.add_runtime_dependency "sqlite3", "~> 1.4"
	spec.add_runtime_dependency "sorbet", "~> 0.4.4366"
	spec.add_runtime_dependency "sorbet-runtime", "~> 0.4.4366"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.12"

end
