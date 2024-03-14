extends CharacterBody3D

const ATTACK_RANGE: int = 3
const SPEED: int = 3

var attacking: bool = false

@onready var model: Node3D = $Worm

@export var player: CharacterBody3D

func _ready():
	
	AutobusLoader.connect("HELLO_WORLD", say_hello)
	
func say_hello():
	print("Line 12-17 Autobus Test Code")

func _physics_process(delta: float) -> void:
	if global_position.distance_to(player.global_position) < ATTACK_RANGE:
		attack()
		return
	
	if attacking:
		return
	
	velocity = global_position.direction_to(player.global_position) * SPEED
	
	model.look_at(player.global_position)
	model.rotate_y(PI) #the sprite is facing backwards
	
	move_and_slide()


func attack() -> void:
	print("Ready... ")
	var timer: SceneTreeTimer = get_tree().create_timer(0.2)
	await timer.timeout
	print("ATTACK PLAYER!")
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(model, "global_position", player.get_infest_point(), 0.25)
	tween.tween_property(model, "scale", Vector3.ZERO, 0.25)
	
	tween.set_ease(tween.EASE_OUT)
	
	await tween.finished
	queue_free()

