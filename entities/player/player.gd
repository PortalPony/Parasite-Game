class_name Player

extends CharacterBody3D

const SPEED: int = 6

var current_state: PlayerState

var target: Vector3 = Vector3.ZERO

var cursor_pos: Vector3 = Vector3(1, 0, 1)

@onready var camera: PlayerCamera = $Camera3D
@onready var human_model: HumanModel = $HumanModel
@onready var health_component: PlayerHealthComponent = $PlayerHealthComponent


func _ready() -> void:
	current_state = PlayerStateIdle.new(human_model)
	health_component.died.connect(on_died)


func _input(event: InputEvent) -> void:
	var new_state: PlayerState = current_state.handle_input(event)
	
	if new_state:
		change_state(new_state)
	
	if event.is_action_pressed("move"):
		print("update target")
		target = camera.mouse_position_3D(cursor_pos)
		target.y = 0


func _physics_process(delta: float) -> void:
	##### Pathfinding #####
	
	# pathfinding to go here to modify the target before computation of velocity
	
	
	var new_state: PlayerState = current_state.calculate_velocity(self, global_position, target)
	
	if new_state:
		change_state(new_state)
	
	new_state = current_state.handle_aim(camera.mouse_object() is Enemy)
	
	if new_state:
		change_state(new_state)
	
	current_state.orientate_model(camera.mouse_position_3D(cursor_pos))
	
	move_and_slide()


func change_state(new_state: PlayerState) -> void:
	# can't change state from the died state:
	if current_state is PlayerStateDead:
		return
	
	current_state.exit()
	current_state = new_state
	current_state.enter()
	current_state.change_state_to.connect(change_state)


func on_died() -> void:
	change_state(PlayerStateDead.new(human_model))
	velocity = Vector3.ZERO


func infest() -> void:
	$PlayerHealthComponent.add_parasite()


func get_infest_point() -> Vector3:
	return $InfestPoint.global_position
