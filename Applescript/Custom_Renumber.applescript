tell application id "com.figure53.QLab.4" to tell front workspace
	set selectedCues to selected as list
	
	display dialog "Prefix" default answer "" with title "Custom Cue Renumbering" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
	if button returned of result = "cancel" then
		return
	else
		set prefixText to (text returned of result) as text
	end if
	
	display dialog "Starting at..." default answer "1" with title "Custom Cue Renumbering" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
	if button returned of result = "cancel" then
		return
	else
		set startNum to (text returned of result) as text
	end if
	
	display dialog "Increment by..." default answer "1" with title "Custom Cue Renumbering" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
	if button returned of result = "cancel" then
		return
	else
		set incrementNum to (text returned of result) as text
	end if
	
	repeat with eachCue in selectedCues
		set q number of eachCue to prefixText & " " & startNum
		set startNum to (startNum + incrementNum)
	end repeat
end tell