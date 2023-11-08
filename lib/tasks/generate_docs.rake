require 'yard'

task :generate_docs do
  YARD::Rake::YardocTask.new do |t|
    t.files   = ['app/**/*.rb']
    t.options = ['--no-private', '--exclude app/views', ' --protected', '-o docs']
    t.stats_options = ['--list-undoc']
  end
  Rake::Task["yard"].execute
end
