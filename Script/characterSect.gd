extends Control

signal back_pressed
signal next_pressed # Sinyal baru untuk maju ke Song Selection

func _ready():
	# Tombol Back (Kiri Atas)
	var btn_back = $Background/MarginContainer/VBoxMain/TopBar/BackButton
	btn_back.pressed.connect(_on_back_button_pressed)
	
	# Tombol Pick Song (Bawah) - Sesuaikan path ini dengan namamu di Scene Tree
	var btn_next = $Background/MarginContainer/VBoxMain/TopBar2/NextButton 
	btn_next.pressed.connect(_on_next_button_pressed)

func _on_back_button_pressed():
	pass # Replace with function body.

func _on_next_button_pressed():
	pass # Replace with function body.
