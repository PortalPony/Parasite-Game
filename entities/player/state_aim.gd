class_name PlayerStateAim

extends PlayerState

var aiming: bool = false

func _init(m: HumanModel, already_aiming) -> void:
	aiming = already_aiming
	super._init(m)

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("shoot"):
		return PlayerStateShoot.new(model)
	
	return null

func handle_aim(at_enemy: bool) -> PlayerState:
	if at_enemy:
		return null
	
	return PlayerStateIdle.new(model)

func enter() -> void:
	if aiming:
		model.play_animation(HumanModel.ANIMATION.AIM)
		return
	
	model.play_animation(HumanModel.ANIMATION.AIM_START)
