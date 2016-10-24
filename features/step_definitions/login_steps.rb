Given (/^I am currently admin$/) do |login|
  @current_user = User.find_by_login(login) || (login == "admin")
end
    