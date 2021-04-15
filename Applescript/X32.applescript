tell application id "com.figure53.qlab.4" to tell front workspace
	
	display dialog "SX Cue Number..." default answer "" with title "Create New SX Cue" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
	set qnum to text returned of result
	
	set typeList to {"Channel", "DCA", "Aux In", "FX Return", "Bus", "Matrix", "Main Stereo", "Main Mono"}
	set cuetype to (choose from list typeList with title "Create New SX Cue" with prompt "Select Cue Type" default items "Channel") as string
	if cuetype is "false" then
		return
	else if cuetype is "Channel" then
		set msgType to "ch"
	else if cuetype is "DCA" then
		set msgType to "dca"
	else if cuetype is "Aux In" then
		set msgType to "auxin"
	else if cuetype is "FX Return" then
		set msgType to "fxrtn"
	else if cuetype is "Bus" then
		set msgType to "bus"
	else if cuetype is "Matrix" then
		set msgType to "mtx"
	else if cuetype is "Main Stereo" then
		set msgType to "main"
	else if cuetype is "Main Mono" then
		set msgType to "main"
	end if
	
	if cuetype is "Main Stereo" then
		set chanNum to "st"
	else if cuetype is "Main Mono" then
		set chanNum to "m"
	else
		display dialog cuetype & " Number..." default answer "" with title "Create New SX Cue" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
		set chanNum to text returned of result as integer
	end if
	
	if cuetype is "Main Stereo" or cuetype is "Main Mono" then
		set chanName to ""
	else
		display dialog cuetype & " Name..." default answer "" with title "Create New SX Cue" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
		set charName to text returned of result
	end if
	
	if chanNum is less than "10" then
		set channelNum to "0" & chanNum as text
	else
		set channelNum to chanNum
	end if
	
	set mutelist to {"Mute On", "Mute Off"}
	set mutetype to (choose from list mutelist with title "Create New SX Cue" with prompt "Select Mute On/Off" default items "Mute On") as string
	
	
	try
		if mutetype is "Mute On" then
			set mute to "0" as text
		else if mutetype is "Mute Off" then
			set mute to "1" as text
		end if
	end try
	
	display dialog "Pre Wait..." default answer "" with title "Create New SX Cue" with icon 1 buttons {"Cancel", "Create"} default button "Create" cancel button "Cancel"
	set prewaitTime to text returned of result as real
	
	make type "Network"
	set thecue to last item of (selected as list)
	set the patch of thecue to 5
	set the osc message type of thecue to custom
	if cuetype is "DCA" then
		set the custom message of thecue to "/" & msgType & "/" & chanNum & "/on " & mute
	else
		set the custom message of thecue to "/" & msgType & "/" & channelNum & "/mix/on " & mute
	end if
	set the pre wait of thecue to prewaitTime
	if mutetype is "Mute On" then
		set the q color of thecue to "red"
	else if mutetype is "Mute Off" then
		set the q color of thecue to "green"
	end if
	if qnum is not "" then
		set the q number of thecue to "SX-" & qnum
	end if
	if cuetype is "Main Stereo" or cuetype is "Main Mono" then
		set the q name of thecue to mutetype & " | " & cuetype as string
	else
		set the q name of thecue to mutetype & " | " & cuetype & " " & chanNum & " - " & charName as string
	end if
	
end tell