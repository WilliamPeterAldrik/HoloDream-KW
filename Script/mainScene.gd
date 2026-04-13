extends Control

# 1. DEKLARASI SINYAL DI SINI (Ini yang bikin error tadi!)
signal start_pressed
signal setting_pressed
signal exit_pressed

var startSignal = true
var settingSignal = true

func _ready():
	# 2. Sambungkan tombol bawaan ke fungsi di script ini
	# (Perhatikan path-nya menyesuaikan nama node di screenshot kamu)
	var menu_list = $Background/MarginContainer/MainLayout/MenuList
	var start = menu_list.get_node("Start")
	if start.is_connected("pressed", _on_start_pressed):
		start.disconnect("pressed", _on_start_pressed)
	start.pressed.connect(_on_start_pressed)

	var setting = menu_list.get_node("Setting")
	if setting.is_connected("pressed", _on_setting_pressed):
		setting.disconnect("pressed", _on_setting_pressed)
	setting.pressed.connect(_on_setting_pressed)

	var exit = menu_list.get_node("Exit")
	if exit.is_connected("pressed", _on_exit_pressed):
		exit.disconnect("pressed", _on_exit_pressed)
	exit.pressed.connect(_on_exit_pressed)

# 3. Pancarkan (emit) sinyal saat tombol diklik
func _on_start_pressed():
	start_pressed.emit()

func _on_setting_pressed():
	setting_pressed.emit()

func _on_exit_pressed():
	exit_pressed.emit()
