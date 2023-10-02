task :prepare_db do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:mongoid:create_indexes"].invoke
  Rake::Task["db:seed"].invoke
end