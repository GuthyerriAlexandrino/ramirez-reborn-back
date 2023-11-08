require 'yard'

YARD::Rake::YardocTask.new do |t|
 t.files   = ['app/**/*.rb']
 t.options = ['--no-private', '--exclude app/views', ' --protected']
 t.stats_options = ['--list-undoc']
end
