tell application id "com.figure53.QLab.4" to tell front workspace
	set allLists to every cue list
	
	set currentList to current cue list
	set countLists to count allLists
	set searchIndex to 1
	repeat until currentList is item searchIndex of allLists
		set searchIndex to searchIndex + 1
	end repeat
	set nextIndex to (searchIndex mod countLists) + 1
	set current cue list to item nextIndex of allLists
end tell