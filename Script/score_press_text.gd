extends Control

# Perfect 61d2d6
# Great 9681f9
# Good 00cf5b
# Ok dfc500
# Miss 757575

func SetTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	
	match text:
		"PERFECT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("61d2d6"))
		"GREAT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("9681f9"))
		"GOOD":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("00cf5b"))
		"OK":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("dfc500"))
		_:
			$ScoreLevelText.set("theme_override_colors/default_color", Color("757575"))
