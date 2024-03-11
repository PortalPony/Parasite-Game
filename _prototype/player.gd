class_name Player

extends CharacterBody3D

const RAY_LENGTH: int = 1000 #arbritrary ray length

const SPEED: int = 6

var target: Vector3 = Vector3.ZERO

@onready var camera: Camera3D = $Camera3D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot()


func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("move"):
		target = move_to(get_viewport().get_mouse_position())
		if not target == global_position:
			target.y = 0
			$Human.run()
			$Human.look_at(target)
			$Human.rotate_y(PI)
			$Human.rotation_degrees.x = 0
			print("Target: ", target, " Human Rotation: ", $Human.rotation)
	
	var dist = global_position.distance_to(target)
	
	if dist < (SPEED * delta):
		velocity = Vector3.ZERO
	else:
		velocity = global_position.direction_to(target) * SPEED
	
	
	move_and_slide()
	if velocity == Vector3.ZERO:
		$Human.idle()


func move_to(pos: Vector2) -> Vector3:
	var space: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	
	query.from = camera.project_ray_origin(pos)
	query.to = query.from + camera.project_ray_normal(pos) * RAY_LENGTH
	
	var result: Dictionary = space.intersect_ray(query)
	
	if not result:
		return global_position
	
	if result["normal"] != Vector3.UP:
		return global_position
	
	return result["position"]


func shoot() -> void:
	if velocity != Vector3.ZERO:
		return
	print("Shooting!")

func get_infest_point() -> Vector3:
	return $InfestPoint.global_position
