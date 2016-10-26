Before ('@summary @scores') do
  DatabaseCleaner.start
end

Before ('@javascript') do
  Capybara.current_driver = :webkit
end
After ('@javascript') do
  Capybara.use_default_driver
end

After ('@summary @scores') do
  DatabaseCleaner.clean
  
end
