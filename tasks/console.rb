desc "Open a console with the #{Bundler::GemHelper.gemspec.name} gem loaded"
task :console do
  require Bundler::GemHelper.gemspec.name

  if RUBY_VERSION >= "2"
    begin
      require "byebug"
    rescue LoadError # rubocop:disable Lint/HandleExceptions
    end
  else
    begin
      require "debugger"
    rescue LoadError # rubocop:disable Lint/HandleExceptions
    end
  end

  begin
    require "pry"
    Pry.start
  rescue LoadError
    require "irb"
    ARGV.clear
    IRB.start
  end
end
