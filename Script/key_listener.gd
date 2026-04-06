extends Sprite2D

# Preload scene yang falling key
@onready
var falling_key = preload("res://Scenes/falling_key.tscn")

# S kiri, D Bawah, K kanan, L Atas
@export
var key_name: String = ""

# Queue key jatoh
var falling_key_queue = []

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
			var front_key = falling_key_queue.front()
			if is_instance_valid(front_key) and not front_key.has_passed:
				front_key.is_handled = true
				front_key.queue_free()
				falling_key_queue.pop_front()
			else:
				print("MISS INPUT")

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
