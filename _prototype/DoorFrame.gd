extends Node3D

var can_open: bool = false

@onready var door: StaticBody3D = $Door
@onready var door_mesh: CSGBox3D = $Door/CSGBox3D
@onready var door_collision_mesh: CollisionShape3D = $Door/CollisionShape3D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		open()

func open() -> void:
	var tween: Tween = get_tree().create_tween()
	
	tween.tween_property(door_mesh, "position", Vector3(0, -4, 0), 0.5)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	
	door_collision_mesh.disabled = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	can_open = body is Player
	print("can open...")


func _on_area_3d_body_exited(body: Node3D) -> void:
	can_open = false if body is Player else can_open
	print("cant open...")
