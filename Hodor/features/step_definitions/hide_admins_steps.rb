Then (/I should not see "([^"]*)"/) do |password|
    page.should have_no_content(password)
end