extends Sprite2D

# kecepatan key nya jatoh
# TODO: di setting, bikin bisa ganti kecepatan jatoh
@export
var fall_speed: float = 3.5
# Posisi y awal key yg jatoh 
var init_y_pos: float = -360

# Kalo lewat jadi true
var has_passed: bool = false
# Posisi pas lewatin input area
<<<<<<< HEAD
var pass_threshold: float = 550.0
var is_handled: bool = false

func on_miss():
	if is_handled:
		return
		is_handled = true
		queue_free()
=======
var pass_threshold: float = 540.0
>>>>>>> b01dd41881bd549f3e60b3365a4e452d58cf7dba

func _init():
	set_process(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(0, fall_speed)
	
	# Indikator key udh lewat apa blom
	if global_position.y > pass_threshold and not $Timer.is_stopped():
		#print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true

# Make sure key yg jatoh frame nya bener
func setup(target_x: float, target_frame: int):
	global_position = Vector2(target_x, init_y_pos)
	frame = target_frame
	set_process(true)
	pass

# Buat Timer hapus key
func _on_out_of_bounds_timeout() -> void:
	queue_free()
	pass # Replace with function body.
