class_name PlayerStateMove

extends PlayerState

const SPEED: int = 6
const DISTANCE_THRESHOLD: float = 0.05

var target: Vector3


func calculate_velocity(body: CharacterBody3D, from: Vector3, to: Vector3) -> PlayerState:
	target = to
	
	if from.distance_to(target) < DISTANCE_THRESHOLD:
		body.velocity = Vector3.ZERO
		return PlayerStateIdle.new(model)
	
	body.velocity = from.direction_to(target) * SPEED
	
	return null


func orientate_model(cursor_position) -> void:
	super.orientate_model(target)


func enter() -> void:
	print("move...")
	model.play_animation(HumanModel.ANIMATION.RUN)

