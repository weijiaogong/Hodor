Given (/the following user exist/) do |user_table|
    user_table.hashes.each do |user|
        Judge.create user
    end
end

When (/^(?:|I )fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

Then (/^(?:|I )should be on the (.*?) page$/) do |arg|
    case arg
		when "admin"
			visit admin_root_path
        else
            raise "Could not find #{arg}"
    end
end
    