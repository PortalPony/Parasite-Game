class_name EnemyHealthBar

extends MarginContainer

@onready var under: TextureProgressBar = $Under
@onready var over: TextureProgressBar = $Over

@export var health_component: HealthComponent

func _ready() -> void:
	health_component.hp_updated.connect(update)
	set_values()


func set_values() -> void:
	over.value = health_component.max_hp
	over.max_value = health_component.max_hp
	over.step = 0.01
	under.value = health_component.max_hp
	under.max_value = health_component.max_hp
	under.step = 0.01


func update(value: int) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(over, "value", value, 0.1)
	tween.tween_property(under, "value", value, 0.75).set_delay(0.5)
	tween.set_ease(tween.EASE_IN_OUT)
