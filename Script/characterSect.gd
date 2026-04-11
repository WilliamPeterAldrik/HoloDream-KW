extends Control

signal back_pressed

func _ready():
	# Sesuaikan path ini dengan posisi tombol Back kamu
	var btn_back = $Background/MarginContainer/VBoxMain/TopBar/BtnBack
	btn_back.pressed.connect(_on_btn_back_pressed)

func _on_btn_back_pressed():
	back_pressed.emit()
