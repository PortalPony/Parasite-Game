extends MeshInstance3D

@onready var interaction_area: InteractionArea = $InteractionsArea3d
@onready var target = $"../Player"

const lines: Array[String] = [
	"Hey Eat Meat"
]


func _ready():
	interaction_area.interact = Callable(self, "on_interact") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_interact():
	queue_free()

