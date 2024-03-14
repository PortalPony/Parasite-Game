class_name HealthComponent

## Class for handling an entities hit points
##
## Manages the HP variable and emits signals when the value changes.

extends Node

## Emitted when the HP changes
signal hp_updated(new_value)
## Emitted when the HP reaches O
signal died

## Current HP. It will be initalised as the max_hp in the ready function
var hp: int

## Adding a health component in editor allows the max hp to be customised. This also represents the Starting HP for an entitiy.
@export var max_hp: int = 10


func _ready() -> void:
	hp = max_hp


## Modify the hit points by the passed in value. Healing is achieved by passing in a negative value. No default value so the ammount of damage given does not need inferring.
func take_damage(value: int) -> void:
	print("damage: ", value)
	hp -= value
	hp = clamp(hp, 0, max_hp)
	
	hp_updated.emit(hp)
	
	if hp == 0:
		died.emit()
