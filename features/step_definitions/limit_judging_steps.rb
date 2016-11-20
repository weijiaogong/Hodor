Then(/^I try to visit judges one posters four judge\?$/) do
    #   visit path_to(fourjudge)
    url = '/judges/1/posters/4/judge'
    current_path = URI.parse(url).path
    visit current_path
end

Then(/^I try to visit judges one posters one judge\?$/) do
    # visit path_to(onejudge)
    url = '/judges/1/posters/1/judge'
    current_path = URI.parse(url).path
    visit current_path
end

