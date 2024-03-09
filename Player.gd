extends RigidBody3D



var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var scale_size = 1
var sc_rate = 1

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var player_mesh = $MeshInstance3D
@onready var player_collisonShape = $CollisionShape3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Player Movement
	var input := Vector3.ZERO
	input.z = Input.get_axis("Forward", "Back")
	input.x = Input.get_axis("Left", "Right")
	input.y = Input.get_axis( "Down", "Jump")
	apply_central_force(twist_pivot.basis * input * 2200.0 * delta)
	
	var aligned_force = twist_pivot.basis * input
	
	#Espcape Key
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#Player Camera
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-70), 
		deg_to_rad(70)
	)
	twist_input = 0.0
	pitch_input = 0.0
	
	
	
	#Scale Player
	player_collisonShape.set_scale(Vector3(scale_size, scale_size, scale_size))
	player_mesh.set_scale(Vector3(scale_size, scale_size, scale_size)) 
	twist_pivot.set_scale(Vector3(scale_size, scale_size, scale_size))
	
	if Input.is_action_pressed('ui_left'):
		scale_size += 0.01 * sc_rate
	if Input.is_action_pressed('ui_right'):
		scale_size -= 0.01 * sc_rate


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
