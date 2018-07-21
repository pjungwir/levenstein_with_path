require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task readme: [] do
  system %q{jq --slurp --raw-input '{"text": "\(.)", "mode": "gfm", "context": "pjungwir/levenstein_with_path"}' < README.md | curl --data @- https://api.github.com/markdown > README.html}
end

if ENV['CI'].nil?
  task default: %w[spec rubocop]
else
  case ENV['SUITE']
  when 'rubocop' then task default: :rubocop
  else                task default: :spec
  end
end
