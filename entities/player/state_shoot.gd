class_name PlayerStateShoot

extends PlayerState

const COOLDOWN: float = 0.25
const IDLE_DELAY: float = 0.5

var aiming: bool = false

var shoot_cooldown: bool = true

func handle_input(event: InputEvent) -> PlayerState:
	if model.is_animation_playing():
		return null
	
	if event.is_action_pressed("move"):
		return PlayerStateMove.new(player, model)
	
	if event.is_action_pressed("shoot"):
		return PlayerStateShoot.new(player, model)
	
	return null

func handle_aim(at_enemy: bool) -> PlayerState:
	aiming = at_enemy
	return null

func orientate_model(_cursor_position) -> void:
	pass

func enter() -> void:
	model.play_animation(HumanModel.ANIMATION.SHOOT)
	
	player.shoot()
	
	await model.animation_player.animation_finished
	
	if aiming:
		change_state_to.emit(PlayerStateAim.new(player, model, aiming))
		return
	
	change_state_to.emit(PlayerStateIdle.new(player, model))

