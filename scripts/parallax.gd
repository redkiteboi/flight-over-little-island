## Parallax effect manager for parallax backgrounds.
class_name Parallax extends ParallaxBackground

## Base speed at which the layers travel towards -x.
@export var speed: float = 0

## Shifts the parallax layers each frame.
func _process(delta):
	offset.x -= speed * delta
	if offset.x <= -240:
		offset.x += 240
