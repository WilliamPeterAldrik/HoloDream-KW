extends Node2D # Ubah ke 'extends Control' jika node utamanya adalah Control

# Pastikan path ini sesuai dengan struktur folder kamu
var scene_start = preload("res://Scenes/UI/SongSelection.tscn")
var scene_character = preload("res://Scenes/UI/CharacterSelection.tscn")
var scene_setting = preload("res://Scenes/UI/Setting.tscn")

var active_scene = null
var menu_main = null

func _ready():
	# Memuat dan menampilkan Menu Utama saat game dimulai
	menu_main = load("res://Scenes/UI/MainMenu.tscn").instantiate()
	add_child(menu_main)
	
	# Menyambungkan sinyal dari Menu Utama
	menu_main.start_pressed.connect(_on_start_pressed)
	menu_main.character_pressed.connect(_on_character_pressed)
	menu_main.setting_pressed.connect(_on_setting_pressed)
	menu_main.exit_pressed.connect(_on_exit_pressed)

# Fungsi inti untuk berganti scene anak
func change_active_scene(new_scene_packed):
	# Sembunyikan Menu Utama
	if menu_main:
		menu_main.hide()
		
	# Hapus scene anak yang lama jika ada
	if active_scene:
		active_scene.queue_free()

	# Tampilkan scene anak yang baru
	active_scene = new_scene_packed.instantiate()
	add_child(active_scene)
	
	# Menyambungkan tombol Back dari scene anak (Karakter/Lagu/Setting)
	if active_scene.has_signal("back_pressed"):
		active_scene.back_pressed.connect(_on_child_back_pressed)

# Fungsi untuk kembali ke Menu Utama
func _on_child_back_pressed():
	if active_scene:
		active_scene.queue_free()
		active_scene = null
		
	if menu_main:
		menu_main.show()

# Penangan Sinyal dari Menu Utama
func _on_start_pressed():
	change_active_scene(scene_start)

func _on_character_pressed():
	change_active_scene(scene_character)

func _on_setting_pressed():
	change_active_scene(scene_setting)

func _on_exit_pressed():
	get_tree().quit()
