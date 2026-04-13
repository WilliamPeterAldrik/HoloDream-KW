extends Sprite2D

# Preload scene yang falling key
@onready
var falling_key = preload("res://Scenes/falling_key.tscn")

# Preload scene score text when pressed
@onready
var score_text = preload("res://Scenes/score_press_text.tscn")

# Preload particles
@onready
var hit_particle = preload("res://Scenes/particles.tscn")


# D kiri, F Bawah, J kanan, Kx Atas
@export
var key_name: String = ""

# Queue key jatoh
var falling_key_queue = []

# Jika distance_from_pass lebih kecil dari threshold, beri score tersebut
var perfect_press_threshold: float = 80
var great_press_threshold: float = 100
var good_press_threshold: float = 120
var ok_press_threshold: float = 180

# Score untuk setiap threshold
var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GlowOverlay.frame = frame 
	Signals.CreateFallingKey.connect(CreateFallingKey)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed(key_name):
		Signals.KeyListenerPress.emit(key_name, frame)
	
	# AI Fixed
	# Kalo lewat layar, dihapus
	while falling_key_queue.size() > 0:
		var front_key = falling_key_queue.front()
		if not is_instance_valid(front_key):
			falling_key_queue.pop_front()
		elif front_key.has_passed:
			falling_key_queue.pop_front()
		else:
			break
			
		var st_inst = score_text.instantiate()
		get_tree().get_root().call_deferred("add_child", st_inst)
		st_inst.SetTextInfo("MISS")
		st_inst.global_position = global_position + Vector2(0, -20)
		Signals.ResetCombo.emit()
	
	# Kalo button di pencet, key nya ilang
	# TODO: Nentuin scoring berdasarkan jarak key jatoh n key input
	if falling_key_queue.size() > 0:
		if Input.is_action_just_pressed(key_name):
			var key_to_pop = falling_key_queue.pop_front()
			
			if is_instance_valid(key_to_pop):
				var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
				
				$AnimationPlayer.stop()
				$AnimationPlayer.play("key_hit")
				
				var press_score_text: String = ""
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
				
				key_to_pop.queue_free()
				
#				Particles
#				AI Generated
				var particle_inst = hit_particle.instantiate()
				get_tree().get_root().add_child(particle_inst)
				particle_inst.global_position = global_position  # at the key listener's position
				particle_inst.emitting = true
				
				var lifetime = particle_inst.lifetime
				get_tree().create_timer(lifetime + 0.1).timeout.connect(particle_inst.queue_free)
				
				var st_inst = score_text.instantiate()
				get_tree().get_root().call_deferred("add_child", st_inst)
				st_inst.SetTextInfo(press_score_text)
				st_inst.global_position = global_position + Vector2(0, -100)
	
	
	

# Bikin Key nya jatoh
func CreateFallingKey(button_name: String):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.setup(position.x, frame)
	
		falling_key_queue.push_back(fk_inst)

# Buat Testing Munculin Key nya
func _on_random_spawn_timeout() -> void:
	#CreateFallingKey()
	$RandomSpawn.wait_time = randf_range(1, 3)
	$RandomSpawn.start()
