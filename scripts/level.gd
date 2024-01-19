## Level logic that manages the gameplay.
class_name Level extends Node2D

## Current state the game is in.
enum State {
	MENU, PLAYING, RESULT
}

## Time the player has to play the game.
@export var time: float = 60

## Singleton instance of the level
static var instance: Level

## Amount of points the player has scored.
var points: int
## Current state the game is in.
var state: State

## Reference to the game timer.
@onready var _timer: Timer = $Timer

## Registers the level as the global instance.
func _enter_tree():
	instance = self

## Initiates the level by switching to the menu state.
func _ready():
	state = State.MENU
	$UI.show_menu()
	_pause()

## Handles input logic.
func _process(delta):
	# Initiate countdown if timer reaches 3 seconds left
	if state == State.PLAYING && !$Countdown.playing && int($UI/HUD/Time.text) == 3:
		$Countdown.play()
	
	# Start button logic
	if Input.is_action_just_pressed("start"):
		match state:
			State.MENU:
				# Start game if player hasn't already
				if !$UI/MainMenu/Jingle.playing:
					_start()
			State.PLAYING:
				# Do nothing
				pass
			State.RESULT:
				# Return to main menu
				state = State.MENU
				$UI/Results/Jingle.play()
				$UI.show_menu()

## Handles player cutscene animations. 
func _physics_process(delta):
	match state:
		State.MENU:
			$Player.position = lerp($Player.position, Vector2(120, 105), 0.05)
		State.PLAYING:
			pass
		State.RESULT:
			$Player.position = lerp($Player.position, Vector2(120, 105), 0.05)

## Starts the game after a short delay, then enables player and spawner behaviour.
func _start():
	# Play short cutscene before starting the game
	$Music.mute()
	$UI/MainMenu/Jingle.play()
	if $UI/MainMenu/Label.visible == false:
		$UI/MainMenu/AnimationPlayer.play("start_on")
	else:
		$UI/MainMenu/AnimationPlayer.play("start_off")
	await $UI/MainMenu/AnimationPlayer.animation_finished
	$UI/MainMenu/AnimationPlayer.play("blink")
	
	# Restart music track
	$Music.reset()
	$Music.play()
	
	# Switch to playing state, reset and timer
	state = State.PLAYING
	$Timer.wait_time = time
	$Timer.start()
	
	# Reset score and show HUD
	points = 0
	$UI.update_score()
	$UI.show_hud()
	
	# Enable player and spawner
	$Player.set_physics_process(true)
	$SpawnerTop.set_physics_process(true)
	$SpawnerBottom.set_physics_process(true)

## Pauses the game by disabling player and spawner behaviour.
func _pause():
	$Player.set_physics_process(false)
	$SpawnerTop.set_physics_process(false)
	$SpawnerBottom.set_physics_process(false)

## Ends game on time out by pausing it and switching to the result screen.
func _time_over():
	_pause()
	state = State.RESULT
	$UI.show_results()

## Increases the score by 1 and updates the counter.
func score():
	points += 1
	$UI.update_score()
