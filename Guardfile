guard :rubocop, all_on_start: false do
  watch(/^.+\.rb$/)
  watch(/^(?:.+\/)?\.rubocop\.yml$/) {|m| File.dirname(m[0]) }
  watch(/^(?:.+\/)?.+\.gemspec$/)
  watch(/^(?:.+\/)?(?:Gem|Rake)file$/)
end

guard :rspec, cmd: "bundle exec rspec -fd" do
  watch(/^spec\/.+_spec\.rb$/)
  watch(/^lib\/(.+)\.rb$/) {|m| "spec/lib/#{m[1]}_spec.rb" }
  watch("spec/spec_helper.rb") { "spec" }
end
