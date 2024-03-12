class_name TutorialTrigger

extends Area3D

@onready var instruction: Label = $CanvasLayer/Label
@export_multiline var text: String = "[insert tutorial text here]"

func _ready() -> void:
	instruction.position = DisplayServer.window_get_size() / 12 * 8
	instruction.size = DisplayServer.window_get_size() / 4
	instruction.modulate = Color.TRANSPARENT
	
	instruction.set_text(text)
	
	body_entered.connect(show_instruction)
	body_exited.connect(hide_instruction)


func show_instruction(body: Node3D) -> void:
	if not body is Player:
		return
	
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(instruction, "position", Vector2(DisplayServer.window_get_size() / 3 * 2), 0.4)
	tween.tween_property(instruction, "modulate", Color.WHITE, 0.3)
	
	tween.set_ease(Tween.EASE_OUT)
	

func hide_instruction(body: Node3D) -> void:
	if not body is Player:
		return
	
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(instruction, "position", Vector2(DisplayServer.window_get_size() / 12 * 8), 0.4)
	tween.tween_property(instruction, "modulate", Color.TRANSPARENT, 0.3).set_delay(0.5)
	
	tween.set_ease(Tween.EASE_OUT)
	
