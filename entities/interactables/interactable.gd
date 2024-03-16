class_name Interactable

extends Node3D

enum TYPE {
	AMMO,
	MEDS,
	FIRST_AID,
	KEY,
}

const PROMPT: Array[String] = [
	"AMMO\n(E)",
	"MEDS\n(E)",
	"FIRST AID KIT\n(E)",
	"KEY\n(E)",
]

var can_collect: bool = false

@onready var label: Label3D = $Label3D
@onready var sfx: AudioStreamPlayer = $SFX

@export var mesh: Node3D
@export var type: TYPE = TYPE.AMMO

func _ready() -> void:
	label.set_text(PROMPT[type])
	label.hide()


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("Interact"):
		return
	
	if not can_collect:
		return
	
	EventBus.interacable_collected.emit(type)
	can_collect = false
	$Area3D.set_monitoring(false)
	sfx.play()
	
	var tween: Tween = get_tree().create_tween()
	
	tween.set_parallel(true)
	
	tween.tween_property(mesh, "position", Vector3(0, 1, 0), 0.75)
	tween.tween_property(mesh, "scale", Vector3.ZERO, 0.75)
	
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	
	queue_free()


func _physics_process(delta: float) -> void:
	mesh.rotation.y += delta * PI / 2


func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body is Player:
		return
	
	can_collect = true
	label.show()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if not body is Player:
		return
	
	can_collect = false
	label.hide()
