extends TextureRect

@export var health_component: HealthComponent

func _ready() -> void:
	health_component.hp_updated.connect(update)


func update(value: int) -> void:
	var tween: Tween = get_tree().create_tween()
	var factor: float = float(value) / health_component.max_hp
	
	var c: Color = Color(factor, factor, factor, 1.0)
	
	print(factor, c)
	tween.tween_property(self, "self_modulate", c, 0.1)
