Then(/^I should see the qrcode$/) do
    expect(page).to have_selector("img[alt='Qrcode']")
end

And(/^I delete qrcode img$/) do
    File.delete("app/assets/images/qrcode.png") if File.exists?("app/assets/images/qrcode.png")
end