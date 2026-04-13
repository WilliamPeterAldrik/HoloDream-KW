extends Control

signal back_pressed

func _ready():
	# Sesuaikan path ini dengan posisi tombol Back kamu
	var btn_back = $Background/MarginContainer/VBoxMain/TopBar/BackButton
	btn_back.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed():
	back_pressed.emit()
