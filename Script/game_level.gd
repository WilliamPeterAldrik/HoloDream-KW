extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pause_ui = get_node("PauseUI")
	var game_ui = get_node("GameUI")
	pause_ui.hide()
	game_ui.show()
