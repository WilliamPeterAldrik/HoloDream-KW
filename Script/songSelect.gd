extends Control

signal back_pressed
signal play_pressed

func _ready():
	print("--- MASUK KE LAYAR SONG SELECTION ---")
	
	# 1. Sambungan Tombol Back
	var btn_back = $Background/MarginContainer/VBoxMain/TopBar/BackButton
	btn_back.pressed.connect(_on_back_pressed)
	
	# 2. Sambungan Tombol Lagu
	var btn_dahlah = $Background/MarginContainer/VBoxMain/SongGrid/dahlahSong
	var btn_gateopen = $Background/MarginContainer/VBoxMain/SongGrid/GateOpenSong
	var btn_tetoris = $Background/MarginContainer/VBoxMain/SongGrid/TetorisSong
	
	btn_dahlah.pressed.connect(_on_dahlah_selected)
	btn_gateopen.pressed.connect(_on_gateopen_selected)
	btn_tetoris.pressed.connect(_on_tetoris_selected)

# --- FUNGSI NAVIGASI ---

func _on_back_pressed():
	print("[RADAR 1] Tombol BACK diklik!")
	back_pressed.emit()
	
func _on_play_button_pressed():
	print("[RADAR 1] Tombol PLAY diklik!")
	
	# Cek apakah lagu sudah dipilih
	if GameManager.selected_song == "":
		print("--> GAGAL: Kamu belum memilih lagu!")
		return
		
	print("--> SUKSES: Mengirim sinyal play_pressed untuk lagu: ", GameManager.selected_song)
	play_pressed.emit()
	
# --- FUNGSI PILIH LAGU ---

func _on_dahlah_selected():
	GameManager.selected_song = "DAHLAH"
	print("Lagu diklik: DAHLAH")

func _on_gateopen_selected():
	GameManager.selected_song = "GATE_OPEN_START"
	print("Lagu diklik: GATE_OPEN_START")

func _on_tetoris_selected():
	GameManager.selected_song = "TETORIS"
	print("Lagu diklik: TETORIS")
