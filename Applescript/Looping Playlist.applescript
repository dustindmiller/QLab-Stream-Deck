tell application id "com.figure53.QLab.4" to tell front workspace
	
	
	set selectedCues to selected as list
	
	set targetCue to first item of selectedCues
	
	if (count selectedCues) is not 0 then
		
		repeat with eachCue in selectedCues
			set continue mode of eachCue to auto_follow
		end repeat
		
		make type "Start"
		set startCue to last item of (selected as list)
		set cue target of startCue to targetCue
		
		make type "Group"
		set groupCue to last item of (selected as list)
		set mode of groupCue to fire_first_go_to_next_cue
		set q name of groupCue to "Looping Playlist"
		
		repeat with newCue in selectedCues
			set newCueID to uniqueID of newCue
			move cue id newCueID of parent of newCue to end of groupCue
		end repeat
		
		set newCueID to uniqueID of startCue
		move cue id newCueID of parent of startCue to end of groupCue
		
	else
		return
	end if
	
	collapse groupCue
	
	##move cue id (uniqueID of cue newTarg) of parent of cue newTarg to end of cue newGroup
	
	
	
end tell