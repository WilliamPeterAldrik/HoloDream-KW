extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("falling_key"):
		print("You Missed!")
		area.on_miss()
	pass # Replace with function body.
