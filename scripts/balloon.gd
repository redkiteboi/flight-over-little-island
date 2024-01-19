## A balloon that will increment the score if popped.
class_name Balloon extends RigidBody2D

## Initial velocity the balloon should have on spawn.
var velocity: Vector2

## Sets the initial velocity to the set value.
func _ready():
	linear_velocity = velocity

## Checks if the balloon has left the screen. If so, it will be deleted.
func _physics_process(delta):
	if position.x < -50:
		queue_free()

## Collision behaviour of the balloon.
func _on_body_entered(body):
	# Only check for collision with projectiles
	if body is Projectile:
		# Increment the score
		Level.instance.score()
		
		# Turn balloon invisible and deactivate further collisions
		$Confetti.emitting = true
		$AnimatedSprite2D.visible = false
		collision_mask = 0
		linear_velocity = velocity
		$AudioStreamPlayer.pitch_scale += randf_range(-0.25, 0.25)
		$AudioStreamPlayer.play()
		
		# Wait for confetti to finish, then delete balloon
		await $Confetti.finished
		queue_free()
