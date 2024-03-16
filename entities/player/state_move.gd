class_name PlayerStateMove

extends PlayerState

const SPEED: int = 6
const DISTANCE_THRESHOLD: float = 0.05

var target: Vector3


func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_released("move"):
		return PlayerStateIdle.new(player, model)
	
	return null


func calculate_velocity(from: Vector3, to: Vector3) -> PlayerState:
	target = to
	
	if from.distance_to(target) < DISTANCE_THRESHOLD:
		return PlayerStateIdle.new(player, model)
	
	player.velocity = from.direction_to(target) * SPEED
	
	return null


func orientate_model(_cursor_position) -> void:
	super.orientate_model(target)


func enter() -> void:
	print("move...")
	model.play_animation(HumanModel.ANIMATION.RUN)


func exit() -> void:
	player.velocity = Vector3.ZERO
