extends Node3D


func _ready():
	AutobusLoader.HELLO_WORLD.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
