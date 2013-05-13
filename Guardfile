guard :rspec, :cli => "--color --format progress", :all_on_start => true do
  watch(%r{^lib/(.+)\.rb$})     { |m| p "spec/unit/#{m[1].sub('dcp/', '')}.spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
  watch(%r{^spec/.+\.spec\.rb$})
end

guard 'shell' do
  watch(%r{lib/.+\.rb})   {|m| system("tailor #{m[0]} --max-line-length 140 --indentation-spaces off") }
  watch(%r{spec/.+\.rb})  {|m| system("tailor #{m[0]} --max-line-length 166 --spaces-before-lbrace off") }
end
Shell.class_eval { def run_all; end }       # disable run_all for guard-shell

guard 'yard', :port => '8808' do
  watch(%r{lib/.+\.rb})
end