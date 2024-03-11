class_name HealthComponent

## Class for handling an entities hit points
##
## Manages the HP variable and emits signals when the value changes.

extends Node

## Emitted when the HP changes
signal hp_updated(new_value)
## Emitted when the HP reaches O
signal dead

## Current HP. It will be initalised as the max_hp
var hp: int = max_hp

## Adding a health component in editor allows the max hp to be customised. This also represents the Starting HP for an entitiy.
@export var max_hp: int = 10

## Modify the hit points by the passed in value. Healing is achieved by passing in a negative value. No default value so the ammount of damage given does not need inferring.
func take_damage(value: int) -> void:
	hp = clamp(hp - value, 0, max_hp)
	
	hp_updated.emit()
	
	if hp == 0:
		dead.emit()
