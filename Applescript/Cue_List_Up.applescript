tell application id "com.figure53.QLab.4" to tell front workspace
	set allLists to every cue list
	
	set currentList to current cue list
	set countLists to count allLists
	set searchIndex to countLists
	
	repeat until currentList is item searchIndex of allLists
		set searchIndex to searchIndex - 1
	end repeat
	set previousIndex to ((searchIndex + countLists - 2) mod countLists) + 1
	set current cue list to item previousIndex of allLists
end tell