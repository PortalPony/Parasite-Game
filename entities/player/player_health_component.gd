class_name PlayerHealthComponent

## Class for handling the players health
##
## As the player is "infested" with a parasite/multiple parasites their health will slowly drain over time as if the parasite(s) are feeding off of them. This is done using a timer that will decrease the players health at regular intervals.

extends HealthComponent

## Emitted when the player is infested by a parasite
signal infested

## Emitted when the player is cured of a parasite
signal cured

## Emitted when the player takes damage
signal damaged

## Time between the player taking damage
const COUNTDOWN: float = 10.0

## Damages player upon timeout
var damage_timer: Timer = Timer.new()
## The number of parasites the player is infested with.
var parasite_count: int = 1

func _ready() -> void:
	start_damage_timer()
	super._ready()


## Starts the damage_timer. Is called upon entering the scene tree. Do not call anywhere else.
func start_damage_timer() -> void:
	damage_timer.set_autostart(true)
	damage_timer.set_wait_time(COUNTDOWN)
	damage_timer.timeout.connect(_on_damage_timer_timeout)
	add_child(damage_timer)
	damage_timer.start()


## increment the parasite count
func add_parasite() -> void:
	parasite_count += 1
	infested.emit()


## decrement the parasite count
func remove_parasite() -> void:
	if parasite_count < 1:
		return
	cured.emit()
	parasite_count -= 1
	


func _on_damage_timer_timeout() -> void:
	if hp < 1:
		damage_timer.stop()
		return
	if parasite_count > 0:
		damaged.emit()
	take_damage(parasite_count)
