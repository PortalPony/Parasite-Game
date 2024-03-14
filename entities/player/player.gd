class_name Player

extends CharacterBody3D

const SPEED: int = 6

var bullets: int = 10

var current_state: PlayerState

var cursor_pos: Vector3 = Vector3(1, 0, 1)

@onready var camera: PlayerCamera = $Camera3D
@onready var human_model: HumanModel = $HumanModel
@onready var health_component: PlayerHealthComponent = $PlayerHealthComponent
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	current_state = PlayerStateIdle.new(self, human_model)
	health_component.died.connect(on_died)


func _input(event: InputEvent) -> void:
	var new_state: PlayerState = current_state.handle_input(event)
	
	if new_state:
		change_state(new_state)


func _physics_process(delta: float) -> void:
	# Pathfinding
	if Input.is_action_pressed("move"):
		if not camera.mouse_object():
			return
		
		nav_agent.set_target_position(camera.mouse_position_3D(cursor_pos))
	
	var next_nav_point = nav_agent.get_next_path_position()
	#
	var new_state: PlayerState = current_state.calculate_velocity(global_position, next_nav_point)
	
	if new_state:
		change_state(new_state)
	
	var mouse_object: Object = camera.mouse_object()
	
	new_state = current_state.handle_aim(mouse_object is Enemy)
	
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
	change_state(PlayerStateDead.new(self, human_model))
	velocity = Vector3.ZERO


func infest() -> void:
	$PlayerHealthComponent.add_parasite()


func get_infest_point() -> Vector3:
	return $InfestPoint.global_position


func add_bullets(value: int) -> void:
	bullets = clamp(bullets, 0, bullets - 1)


func shoot() -> void:
	print("shot")
	
	if not bullets > 0:
		return
	
	add_bullets(-1)
	
	var mouse_object: Object = camera.mouse_object()
	
	if mouse_object is Enemy:
		mouse_object as Enemy
		mouse_object.take_damage(1)

