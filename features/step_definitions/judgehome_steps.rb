 include WaitForAjax
 
 Then /^(.*) within the dialog$/ do |step_cmd|
   page.find('.ui-dialog',  match: :first)
   within(".ui-dialog") do
      step step_cmd
   end
 end
 
 When /^(.*) trigger dialog$/ do |step_cmd|
    step step_cmd
    page.find('.ui-dialog',  match: :first)
    #page.evaluate_script("$('#leave-confirm').dialog('open');")
    #page.save_screenshot('screen.png')
 end