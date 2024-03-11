extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	idle()


func idle() -> void:
	animation_player.play("player_idle")


func run() -> void:
	animation_player.play("player_run")
