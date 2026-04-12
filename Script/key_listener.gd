extends Sprite2D

# Preload scene yang falling key
@onready
var falling_key = preload("res://Scenes/falling_key.tscn")

# Preload scene score text when pressed
@onready
var score_text = preload("res://Scenes/score_press_text.tscn")

# D kiri, F Bawah, J kanan, Kx Atas
@export
var key_name: String = ""

# Queue key jatoh
var falling_key_queue = []

# Jika distance_from_pass lebih kecil dari threshold, beri score tersebut
var perfect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80

# Score untuk setiap threshold
var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Kalo lewat layar, dihapus
	if falling_key_queue.size() > 0:
		var front_key = falling_key_queue.front()
		if is_instance_valid(front_key) and falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
	
	# Kalo button di pencet, key nya ilang
	# TODO: Nentuin scoring berdasarkan jarak key jatoh n key input
		if Input.is_action_just_pressed(key_name):
			if falling_key_queue.size() > 0:
				var key_to_pop = falling_key_queue.pop_front()
				if is_instance_valid(key_to_pop):
					var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
					
					var press_score_text = ""
					if distance_from_pass < perfect_press_threshold:
						Signals.IncrementScore.emit(perfect_press_score)
						press_score_text = "PERFECT"
						Signals.IncrementCombo.emit()
					elif distance_from_pass < great_press_threshold:
						Signals.IncrementScore.emit(great_press_score)
						press_score_text = "GREAT"
						Signals.IncrementCombo.emit()
					elif distance_from_pass < good_press_threshold:
						Signals.IncrementScore.emit(good_press_score)
						press_score_text = "GOOD"
						Signals.IncrementCombo.emit()
					elif distance_from_pass < ok_press_threshold:
						Signals.IncrementScore.emit(ok_press_score)
						press_score_text = "OK"
						Signals.IncrementCombo.emit()
					else:
						press_score_text = "MISS"
						Signals.ResetCombo.emit()
						pass
					
					key_to_pop.queue_free()
					
					var st_inst = score_text.instantiate()
					get_tree().get_root().call_deferred("add_child", st_inst)
					st_inst.SetTextInfo(press_score_text)
					st_inst.global_position = global_position

# Bikin Key nya jatoh
func createFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.setup(position.x, frame)
	
	falling_key_queue.push_back(fk_inst)

# Buat Testing Munculin Key nya
func _on_random_spawn_timeout() -> void:
	createFallingKey()
	$RandomSpawn.wait_time = randf_range(1, 3)
	$RandomSpawn.start()
