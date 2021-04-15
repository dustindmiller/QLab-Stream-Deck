tell application id "com.figure53.QLab.4" to tell front workspace
	
	display dialog "Act Roman Numberal..." default answer "" with title "Create New Act – Scene Break" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
	set ActNum to text returned of result
	
	display dialog "Scene Number..." default answer "" with title "Create New Act – Scene Break" with icon 1 buttons {"Cancel", "Create"} default button "Create" cancel button "Cancel"
	set sceneNum to text returned of result
	
	set continueList to {"Do Not Continue", "Auto Continue", "Auto Follow"}
	set continueChoice to (choose from list continueList with title "Create New Act – Scene Break" with prompt "Select Continue Option") as string
	
	make type "Memo"
	set thecue to last item of (selected as list)
	set q color of thecue to "BastardAmber"
	set q number of thecue to ActNum & " – " & sceneNum
	set q name of thecue to "Act " & ActNum & " – Scene " & sceneNum
	if continueChoice is "Do Not Continue" then
		set continue mode of thecue to do_not_continue
	else if continueChoice is "Auto Continue" then
		set continue mode of thecue to auto_continue
	else if continueChoice is "Auto Follow" then
		set continue mode of thecue to auto_follow
	end if
	
end tell