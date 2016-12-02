Before ('@summary @scores @judgehome') do
  DatabaseCleaner.start
end

Before ('@javascript') do
  Capybara.current_driver = :webkit
end
After ('@javascript') do
  Capybara.use_default_driver
end

After ('@summary @scores @judgehome') do
  DatabaseCleaner.clean
  
end
