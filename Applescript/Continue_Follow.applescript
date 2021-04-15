tell application id "com.figure53.QLab.4" to tell front workspace
	
	set thisCue to selected as list
	
	repeat with eachCue in thisCue
		if continue mode of eachCue is do_not_continue then
			set continue mode of eachCue to auto_continue
		else if continue mode of eachCue is auto_continue then
			set continue mode of eachCue to auto_follow
		else if continue mode of eachCue is auto_follow then
			set continue mode of eachCue to do_not_continue
		end if	
	end repeat

end tell