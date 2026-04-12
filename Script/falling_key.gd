extends Sprite2D

# kecepatan key nya jatoh
# TODO: di setting, bikin bisa ganti kecepatan jatoh
@export
var fall_speed: float = 2.5
# Posisi y awal key yg jatoh 
var init_y_pos: float = -360

# Kalo lewat jadi true
var has_passed: bool = false
# Posisi pas lewatin input area

var pass_threshold: float = 540.0


func _init():
	set_process(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var calculated_speed = (pass_threshold - init_y_pos) / 2.0
	global_position += Vector2(0, calculated_speed * delta)
	
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
