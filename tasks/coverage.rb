desc "Run tests and generate coverage report"
task :coverage do
  ENV["COVERAGE"] = "true"
  Rake::Task[:spec].invoke
end
