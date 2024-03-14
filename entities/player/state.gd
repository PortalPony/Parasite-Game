class_name PlayerState

extends Node

signal change_state_to(state: PlayerState)

var model: HumanModel
var player: Player

func _init(p: Player, m: HumanModel) -> void:
	player = p
	model = m


func handle_input(event: InputEvent) -> PlayerState:
	return null


func calculate_velocity(from: Vector3, to: Vector3) -> PlayerState:
	return null


func handle_aim(at_enemy: bool) -> PlayerState:
	return null


func orientate_model(cursor_position) -> void:
	model.look_at(cursor_position)
	model.rotate_y(PI)
	model.rotation_degrees.x = 0


func enter() -> void:
	pass

func exit() -> void:
	pass

