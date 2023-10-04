require 'yard'

YARD::Rake::YardocTask.new do |t|
 t.files   = ['app/**/*.rb']
 t.options = ['-o docs'] # optional
 t.stats_options = ['--list-undoc']
end
