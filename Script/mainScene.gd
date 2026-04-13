extends Control

# 1. DEKLARASI SINYAL DI SINI (Ini yang bikin error tadi!)
signal start_pressed
signal setting_pressed
signal exit_pressed

func _ready():
	# 2. Sambungkan tombol bawaan ke fungsi di script ini
	# (Perhatikan path-nya menyesuaikan nama node di screenshot kamu)
	var menu_list = $Background/MarginContainer/MainLayout/MenuList
	
	menu_list.get_node("Start").pressed.connect(_on_start_pressed)
	menu_list.get_node("Setting").pressed.connect(_on_setting_pressed)
	menu_list.get_node("Exit").pressed.connect(_on_exit_pressed)

# 3. Pancarkan (emit) sinyal saat tombol diklik
func _on_start_pressed():
	start_pressed.emit() 

func _on_setting_pressed():
	setting_pressed.emit()

func _on_exit_pressed():
	exit_pressed.emit()
