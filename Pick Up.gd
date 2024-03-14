extends MeshInstance3D

var can_interact = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	can_interact = true # Replace with function body.
	print("interact on")


func _on_area_3d_body_exited(body):
	can_interact = false 
	print("inter off")

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		queue_free()
		AutobusLoader.ui_change.emit()
