Then(/^I should see the qrcode$/) do
    expect(page).to have_selector("img[alt='Qrcode']")
end