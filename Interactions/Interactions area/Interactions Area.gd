extends Area3D

class_name InteractionArea


@export var action_name: String = "interact"
var can_interact = true

var interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self)
	


func _on_body_exited(body):
	InteractionManager.unregister_area(self)

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		queue_free()
