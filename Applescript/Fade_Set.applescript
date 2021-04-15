tell application id "com.figure53.QLab.4" to tell front workspace
	
	set targetCue to last item of (selected as list)
	
	if q type of targetCue is "Audio" or q type of targetCue is "Mic" or q type of targetCue is "Video" or q type of targetCue is "Camera" or q type of targetCue is "Text" then
		
		display dialog "Fade In Duration..." default answer "" with title "Create New Fade Cue Set" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
		
		if button returned of result = "cancel" then
			return
		else
			set inDuration to (text returned of result) as text
		end if
		
		display dialog "Fade Out Duration..." default answer "" with title "Create New Fade Cue Set" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
		
		if button returned of result = "cancel" then
			return
		else
			set outDuration to (text returned of result) as text
		end if
		
		try
			if q type of targetCue is "Video" or q type of targetCue is "Camera" or q type of targetCue is "Text" then
				
				display dialog "Fade Minimum Opacity..." default answer "" with title "Create New Fade Cue Set" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
				
				if button returned of result = "cancel" then
					return
				else
					set minOpacity to (text returned of result) as text
				end if
			end if
		end try
		
		try
			if q type of targetCue is "Video" or q type of targetCue is "Audio" or q type of targetCue is "Mic" then
				
				display dialog "Fade Minimum Volume..." default answer "" with title "Create New Fade Cue Set" with icon 1 buttons {"Cancel", "Create"} default button "Create" cancel button "Cancel"
				
				if button returned of result = "cancel" then
					return
				else
					set minVolume to (text returned of result) as text
				end if
			end if
		end try
		
		set targetCue to last item of (selected as list)
		set groupNum to q number of targetCue
		set groupName to q name of targetCue as text
		set q number of targetCue to groupNum & ".target"
		
		make type "Fade"
		set fadeOutCue to last item of (selected as list)
		set the q number of fadeOutCue to groupNum & ".out"
		set cue target of fadeOutCue to targetCue
		
		if outDuration is not "" then
			set duration of fadeOutCue to outDuration
		end if
		
		set q name of fadeOutCue to "Fade Out and Stop " & groupName
		set stop target when done of fadeOutCue to true
		
		try
			if q type of targetCue is "Video" or q type of targetCue is "Camera" or q type of targetCue is "Text" then
				set videoCueLevel to opacity of targetCue
				if minOpacity is "" then
					set do opacity of fadeOutCue to true
					set opacity of fadeOutCue to 0
				else
					set do opacity of fadeOutCue to true
					set opacity of fadeOutCue to minOpacity
				end if
				moveSelectionUp
			end if
		end try
		
		try
			if q type of targetCue is "Video" or q type of targetCue is "Audio" or q type of targetCue is "Mic" then
				set cueLevel to targetCue getLevel row 0 column 0
				if minVolume is "" then
					fadeOutCue setLevel row 0 column 0 db -60
				else
					fadeOutCue setLevel row 0 column 0 db minVolume
				end if
				moveSelectionUp
			end if
		end try
		
		make type "Fade"
		set fadeCue to last item of (selected as list)
		set q number of fadeCue to groupNum & ".in"
		set cue target of fadeCue to targetCue
		
		set fadeCue to last item of (selected as list)
		
		if inDuration is not "" then
			set duration of fadeCue to inDuration
		end if
		
		set q name of fadeCue to "Fade In " & groupName
		try
			if q type of targetCue is "Video" or q type of targetCue is "Camera" or q type of targetCue is "Text" then
				set opacity of fadeCue to videoCueLevel
				if minOpacity is "" then
					set do opacity of fadeCue to true
					set opacity of targetCue to 0
				else
					set do opacity of fadeCue to true
					set opacity of targetCue to minOpacity
				end if
			end if
		end try
		try
			if q type of targetCue is "Video" or q type of targetCue is "Audio" or q type of targetCue is "Mic" then
				fadeCue setLevel row 0 column 0 db cueLevel
				if minVolume is "" then
					targetCue setLevel row 0 column 0 db -60
				else
					targetCue setLevel row 0 column 0 db minVolume
				end if
			end if
		end try
		set cuesToGroup to {targetCue, fadeCue}
		make type "Group"
		set groupCue to last item of (selected as list)
		set q number of groupCue to groupNum
		set mode of groupCue to fire_all
		set q name of groupCue to groupName & " + Fade In"
		repeat with eachCue in cuesToGroup
			set eachCueID to uniqueID of eachCue
			move cue id eachCueID of parent of eachCue to end of groupCue
		end repeat
		
		collapse groupCue
	else
		display dialog "Cue Type Does Not Fade" with title "Create New Fade Cue Set" with icon 2 buttons "OK" default button "OK"
	end if
end tell