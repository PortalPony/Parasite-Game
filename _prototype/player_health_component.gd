class_name PlayerHealthComponent

## Class for handling the players health
##
## As the player is "infested" with a parasite/multiple parasites their health will slowly drain over time as if the parasite(s) are feeding off of them. This is done using a timer that will decrease the players health at regular intervals.

extends HealthComponent

## Time between the player taking damage
const COUNTDOWN: float = 15.0

## Damages player upon timeout
var damage_timer: Timer = Timer.new()
## The number of parasites the player is infested with.
var parasite_count: int = 1

func _ready() -> void:
	start_damage_timer()


## Starts the damage_timer. Is called upon entering the scene tree. Do not call anywhere else.
func start_damage_timer() -> void:
	damage_timer.set_autostart(true)
	damage_timer.set_wait_time(COUNTDOWN)
	damage_timer.timeout.connect(take_damage, parasite_count)
	
	add_child(damage_timer)


## increment the parasite count
func add_parasite() -> void:
	parasite_count += 1


## decrement the parasite count
func remove_parasite() -> void:
	if parasite_count < 1:
		return
	
	parasite_count -= 1
	
