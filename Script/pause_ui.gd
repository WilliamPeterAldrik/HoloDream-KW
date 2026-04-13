extends Control

signal play_pressed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("--- MASUK KE LAYAR PAUSE ---")

	var btn_quit = $QuitButton
	var btn_retry = $RetryButton
	var btn_continue = $ContinueButton
	
	btn_quit.pressed.connect(_on_quit_button_pressed)
	btn_retry.pressed.connect(_on_retry_button_pressed)
	btn_continue.pressed.connect(_on_continue_button_pressed)
	
func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_continue_button_pressed() -> void:
	hide()
	get_node("../GameUI").show()
	get_node("../LeftArrow").show()
	get_node("../DownArrow").show()
	get_node("../RightArrow").show()
	get_node("../UpArrow").show()
	get_node("../LevelEditor").show()
	get_tree().paused = false
	# TODO: Lanjutin gamenya


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/SongSelection.tscn")
