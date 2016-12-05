 include  WaitForAjax

 When /^I follow "Sign out" and press "Yes" within the dialog$/ do
     page.accept_confirm  do
         click_link "Sign out"
     end
 end
 
When /^I follow "Sign out" and press "No" within the dialog$/ do
    page.dismiss_confirm do
         click_link "Sign out"
    end
end

When /^I follow "Sign out" without triggerring dialog$/ do
    click_link "Sign out"
    wait_for_ajax
 end