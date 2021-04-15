tell application id "com.figure53.qlab.4" to tell front workspace
	
	display dialog "LX Cue Number..." default answer "" with title "Create New LX Cue" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
	set qnum to text returned of result
	
	set consolelist to {"Eos", "Hog"}
	set consoletype to (choose from list consolelist with title "Create New LX Cue" with prompt "Console System Type" default items "Eos") as string
	
	if consoletype is "false" then
		return
	else if consoletype is "Eos" then
		set consoleOSC to "/eos/cue/" as text
		set consoleOSC2 to "/fire" as text
	else if consoletype is "Hog" then
		set consoleOSC to "/hog/playback/go/0/" as text
		set consoleOSC2 to "" as text
	end if
	
	if consoletype is "Eos" then
		display dialog "Eos Cue List/Number..." default answer "#/#" with title "Create New LX Cue for Eos System" with icon 1 buttons {"Cancel", "Create"} default button "Create" cancel button "Cancel"
		
		if button returned of result = "cancel" then
			return
		else
			set lxnum to (text returned of result) as text
		end if
		
	else if consoletype is "Hog" then
		display dialog "Hog Cue List.Number..." default answer "#.#" with title "Create New LX Cue for Hog System" with icon 1 buttons {"Cancel", "Create"} default button "Create" cancel button "Cancel"
		
		if button returned of result = "cancel" then
			return
		else
			set lxnum to (text returned of result) as text
			
		end if
	end if
	
	make type "Network"
	set thecue to last item of (selected as list)
	set the patch of thecue to 4
	set the osc message type of thecue to custom
	set the custom message of thecue to consoleOSC & lxnum & consoleOSC2
	set the q name of thecue to "Fire | " & consoletype & " System | Cue " & lxnum
	if qnum is not "" then
		set the q number of thecue to "LX-" & qnum
	end if
	
end tell