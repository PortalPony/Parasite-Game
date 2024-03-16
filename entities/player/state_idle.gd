class_name PlayerStateIdle

extends PlayerState


func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("move"):
		return PlayerStateMove.new(player, model)
	
	if event.is_action_pressed("shoot"):
		return PlayerStateShoot.new(player, model)
	
	return null


func _move_to(_pos: Vector3) -> Vector3:
	return Vector3.ZERO


func handle_aim(at_enemy: bool) -> PlayerState:
	if at_enemy:
		return PlayerStateAim.new(player, model, false)
	
	return super.handle_aim(at_enemy)


func enter() -> void:
	model.play_animation(HumanModel.ANIMATION.IDLE)
