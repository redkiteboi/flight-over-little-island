## Background music that can be muted if needed.
class_name Music extends AudioStreamPlayer

## Singleton instance of the music.
static var instance: Music

## Default music volume.
@onready var volume = volume_db

## Registers the music as the global instance.
func _enter_tree():
	instance = self

## Gradually decreases the music volume until it is muted.
func mute():
	$AnimationPlayer.play("mute")

## Gradually increases the music volume until it is fully unmuted.
func unmute():
	$AnimationPlayer.play_backwards("mute")

## Resets the music to its default volume.
func reset():
	$AnimationPlayer.stop()
	volume_db = volume
