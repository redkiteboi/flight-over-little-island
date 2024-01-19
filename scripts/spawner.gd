## Position in 2D space that continuously spawns balloons.
class_name Spawner extends Node2D

## Balloon that will be spawned.
@export var balloon: PackedScene
## Time that should pass until a new balloon spawns.
@export var cooldown: float = 1
## Amount of time that should pass before spawning the first balloon.
@export var delay: float = 0

## Internal cooldown that ticks down.
@onready var _cooldown: float = delay

## Decreased the spawn cooldown by the time passed.
## Spawns a balloon and resets cooldown if it hit or passed 0.
func _physics_process(delta):
	_cooldown -= delta
	if _cooldown <= 0:
		_spawn()
		_cooldown = cooldown

## Spawns a new ballon and applies a random velocity to it.
func _spawn():
	var b = balloon.instantiate()
	b.position = position
	b.velocity = Vector2.LEFT * 150
	b.velocity += Vector2.UP * randf_range(-50, 50)
	get_parent().add_child(b)
