class_name HumanModel

extends Node3D

enum ANIMATION{
	IDLE,
	RUN,
	AIM_START,
	AIM,
	SHOOT,
	DIE,
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	play_animation(ANIMATION.IDLE)


func play_animation(anim: ANIMATION) -> void:
	match anim:
		ANIMATION.IDLE:
			animation_player.play("player_idle")
		ANIMATION.RUN:
			animation_player.play("player_run")
		ANIMATION.AIM_START:
			animation_player.play("pistol_aim_start")
			animation_player.queue("pistol_aiming")
		ANIMATION.AIM:
			animation_player.play("pistol_aiming")
		ANIMATION.SHOOT:
			animation_player.play("pistol_shoot")
		ANIMATION.DIE:
			animation_player.play("player_die_1")


func is_animation_playing() -> bool:
	return animation_player.is_playing()

