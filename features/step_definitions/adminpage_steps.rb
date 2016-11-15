Then(/^I should see (\d+) rows in the table$/) do |arg1|
    expect(all("table tr").count).to eq arg1.to_i
end