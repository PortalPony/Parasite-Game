class_name PlayerStateAim

extends PlayerState

var aiming: bool = false

func _init(p: Player, m: HumanModel, already_aiming) -> void:
	aiming = already_aiming
	super._init(p, m)

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("shoot"):
		return PlayerStateShoot.new(player, model)
	
	return null

func handle_aim(at_enemy: bool) -> PlayerState:
	if at_enemy:
		return null
	
	return PlayerStateIdle.new(player, model)

func enter() -> void:
	if aiming:
		model.play_animation(HumanModel.ANIMATION.AIM)
		return
	
	model.play_animation(HumanModel.ANIMATION.AIM_START)
