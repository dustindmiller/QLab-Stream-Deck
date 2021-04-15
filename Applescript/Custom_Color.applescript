tell application id "com.figure53.QLab.4" to tell front workspace

	set thisCue to last item of (selected as list)
	set currentColor to q color of thisCue
	set colorList to {"None", "Rufous", "Vermilion", "Red", "Scarlet", "Coral", "Taupe", "Bastardamber", "Bisque", "Ecru", "Orange", "Fulvous", "Ochre", "Maize", "Yellow", "Olive", "Chartreuse", "Sage", "Avocado", "Green", "Seafoamgreen", "Celadon", "Viridian", "Verdigris", "Skyblue", "Glaucous", "Cerulean", "Blue", "Indigo", "Mauve", "Fuchsia", "Purple", "Puce", "Lilac", "Grey"}
	
	set myColor to (choose from list colorList with title "Cue Color" with prompt "Select color for selected cue(s)..." default items currentColor)
	
	set myOSC2 to "/cue/selected/colorName " & myColor
	do shell script "echo " & myOSC2 & " | nc -u -w 0 127.0.0.1 53535"
	
end tell