## Player character that will be controlled by the player.
class_name Player extends CharacterBody2D

## Speed at which the player will be moving in a direction.
@export var speed: float = 400
## Projectile that will be shot.
@export var projectile: PackedScene
## Time that has to pass between two projectiles being shot.
@export var base_cooldown: float = 60.0/140.0

## Internal cooldown that ticks down.
var cooldown: float = 0

func _ready():
	$AnimationPlayer.speed_scale = 140.0/120.0

func _physics_process(delta):
	# Calculate player velocity from input direction
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * speed
	
	# Save old position before moving (needed for later)
	var oldx = position.x
	var oldy = position.y
	
	# Move player in set direction
	move_and_slide()
	
	# Code that prevent staircase pixel jittering
	# Source: https://www.reddit.com/r/godot/comments/cvn6qn/ive_figured_out_a_way_to_smooth_out_jittery/
	if velocity:
		var x
		var y
		if abs(oldx - position.x) > abs(oldy - position.y): 
			x = round(position.x)
			y = round(position.y + (x - position.x) * velocity.y / velocity.x)
			position.y = y
		elif abs(oldx - position.x) <= abs(oldy - position.y):
			y = round(position.y)
			x = round(position.x + (y - position.y) * velocity.x / velocity.y)
			position.x = x
	
	# Limit the player's position to the size of the screen
	position.x = clamp(position.x, 0, 240)
	position.y = clamp(position.y, 0, 160)
	
	# Subtract passed time from cooldown
	if cooldown > 0:
		cooldown -= delta
	
	# Shoot projectile if player shoots and there is no cooldown
	if (Input.is_action_pressed("shoot") && cooldown <= 0):
		_shoot()

## Shoots a projectile from the player's position.
func _shoot():
	var p: Node2D = projectile.instantiate()
	p.position = position
	get_parent().add_child(p)
	
	# Reset cooldown
	while cooldown <= 0:
		cooldown += base_cooldown
	
	# Play shoot sound
	$AudioStreamPlayer2D.play()
