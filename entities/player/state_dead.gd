class_name PlayerStateDead

extends PlayerState


func orientate_model(cursor_position) -> void:
	pass


func enter() -> void:
	model.play_animation(HumanModel.ANIMATION.DIE)
