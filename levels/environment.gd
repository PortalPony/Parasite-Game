@tool
extends WorldEnvironment

@export var active: bool = false :
	set(value):
		active = value
		if active:
			environment.fog_enabled = true
			environment.reflected_light_source = Environment.REFLECTION_SOURCE_DISABLED
		if not active:
			environment.fog_enabled = false
			environment.reflected_light_source = Environment.REFLECTION_SOURCE_BG

func _ready() -> void:
	active = true
