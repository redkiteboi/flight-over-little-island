## Projectile that shoots to the right.
class_name Projectile extends RigidBody2D

## Speed at which the projectile travels.
var speed: float = 500

## Applies initial velocity to the projectile.
func _ready():
	linear_velocity = Vector2(speed, 0)

## Checks if the projectile has left the screen. If so, it will be deleted.
func _physics_process(delta):
	if position.x > 300:
		queue_free()

## Deletes the projectile if it has hit another body.
func _on_body_entered(body):
	queue_free()
