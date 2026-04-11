extends Control

# Mendefinisikan sinyal kustom
signal start_pressed
signal character_pressed
signal setting_pressed
signal exit_pressed

func _ready():
	# Sesuaikan path ini jika hierarki node kamu sedikit berbeda
	var menu_list = $Background/MarginContainer/MainLayout/MenuList
	
	menu_list.get_node("BtnStart").pressed.connect(_on_btn_start_pressed)
	menu_list.get_node("BtnCharacter").pressed.connect(_on_btn_character_pressed)
	menu_list.get_node("BtnSetting").pressed.connect(_on_btn_setting_pressed)
	menu_list.get_node("BtnExit").pressed.connect(_on_btn_exit_pressed)

func _on_btn_start_pressed():
	start_pressed.emit()

func _on_btn_character_pressed():
	character_pressed.emit()

func _on_btn_setting_pressed():
	setting_pressed.emit()

func _on_btn_exit_pressed():
	exit_pressed.emit()
