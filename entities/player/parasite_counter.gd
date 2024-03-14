extends MarginContainer

var worm_sprite: CompressedTexture2D = preload("res://assets/ui/worm_sprite.png")

@export var player_health_component: PlayerHealthComponent

func _ready() -> void:
	pass
	player_health_component.infested.connect(add_parasite)

func add_parasite() -> void:
	var w: TextureRect = TextureRect.new()
	w.texture = worm_sprite
	$VBoxContainer.add_child(w)
	
	
