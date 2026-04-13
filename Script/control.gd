extends Control

# Character selection di-comment/dimatikan dulu karena kita lompat langsung ke Song Selection
# var scene_character = preload("res://Scenes/UI/CharacterSelection.tscn")
var scene_song = preload("res://Scenes/UI/SongSelection.tscn")
var scene_setting = preload("res://Scenes/UI/Setting.tscn")

# Ganti dengan path scene gameplay kamu yang sebenarnya
var scene_gameplay = preload("res://Scenes/game_level.tscn") 

var active_scene = null
var menu_main = null

func _ready():
	# Tampilkan Main Menu saat awal
	show_main_menu()

func clear_active_scene():
	if active_scene:
		active_scene.queue_free()
		active_scene = null

func show_main_menu():
	clear_active_scene()
	if not menu_main:
		menu_main = load("res://Scenes/UI/MainMenu.tscn").instantiate()
		add_child(menu_main)
		
		# Sambungkan sinyal Menu Utama
		# UBAH DI SINI: Tombol Start sekarang langsung memanggil load_song_selection
		menu_main.start_pressed.connect(load_song_selection) 
		menu_main.setting_pressed.connect(load_setting)
		menu_main.exit_pressed.connect(get_tree().quit)
	else:
		menu_main.show()

func load_song_selection():
	if menu_main: menu_main.hide()
	clear_active_scene()
	
	active_scene = scene_song.instantiate()
	add_child(active_scene)
	
	# SAMBUNGAN SINYAL (Pastikan dua baris ini ada!)
	active_scene.back_pressed.connect(show_main_menu)
	active_scene.play_pressed.connect(load_gameplay)
	
func load_gameplay():
	print("[RADAR 2] Sinyal dari tombol Play berhasil ditangkap oleh Control!")
	clear_active_scene()
	
	print("[RADAR 3] Sedang memuat game_level.tscn...")
	active_scene = scene_gameplay.instantiate()
	add_child(active_scene)
	print("[RADAR 4] SELAMAT BERMAIN!")

func load_setting():
	if menu_main: menu_main.hide()
	clear_active_scene()
	
	active_scene = scene_setting.instantiate()
	add_child(active_scene)
	
	active_scene.back_pressed.connect(show_main_menu)
