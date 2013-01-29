task :default => 'tests:run_test'

desc "Run Textile to Html and Html to Textile tests."
namespace :tests do
  task :run_test
    ruby "test/TestConvertHtmlToTextileController.rb"
    ruby "test/TestConvertTextileToHtmlController.rb"
end