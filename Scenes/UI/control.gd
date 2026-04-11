extends Node2D # Atau Control

# Referensi ke container tempat scene anak dimuat
@onready var content_container = $ContentArea

# Muat (pre-load) scene-scene yang akan digunakan
var scene_start = preload("res://Scenes/UI/SongSelection.tscn")
var scene_character = preload("res://Scenes/UI/CharacterSelection.tscn")
var scene_setting = preload("res://Scenes/UI/Setting.tscn")

var active_scene = null

func _ready():
	# Muat Menu Utama secara default
	var menu_main = load("res://Scenes/UI/MainMenu.tscn").instance()
	add_child(menu_main)
	# Hubungkan sinyal dari tombol Menu Utama ke fungsi penanganan
	menu_main.connect("start_pressed", self, "_on_start_pressed")
	menu_main.connect("character_pressed", self, "_on_character_pressed")
	menu_main.connect("setting_pressed", self, "_on_setting_pressed")
	menu_main.connect("exit_pressed", self, "_on_exit_pressed")

# Fungsi untuk memuat scene baru ke dalam container
func change_active_scene(new_scene_packed):
	# Hapus scene aktif sebelumnya jika ada
	if active_scene:
		active_scene.queue_free()

	# Buat instance baru
	active_scene = new_scene_packed.instance()
	content_container.add_child(active_scene)

# Penangan Sinyal
func _on_start_pressed():
	change_active_scene(scene_start)

func _on_character_pressed():
	change_active_scene(scene_character)

func _on_setting_pressed():
	change_active_scene(scene_setting)

func _on_exit_pressed():
	# Contoh: Tutup game
	get_tree().quit()
