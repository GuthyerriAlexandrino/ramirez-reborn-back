require 'yard'

YARD::Rake::YardocTask.new do |t|
 t.files   = ['app/**/*.rb']
 t.options = ['-n', '--exclude app/views']
 t.stats_options = ['--list-undoc']
end
