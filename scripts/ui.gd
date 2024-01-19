## Game UI functionality.
class_name UI extends CanvasLayer

## Reference to the current level instance.
@onready var level: Level = Level.instance

## Shows the main menu on game start.
func _ready():
	show_menu()

## Updates the timer label to current time left.
func _process(delta):
	var time_left = floor(remap(level._timer.time_left, 0, level.time, 0, 79.5))
	$HUD/Time.text = String.num(time_left).pad_zeros(2)

## Updates the score label to the current amount of points.
func update_score():
	$HUD/Score.text = String.num(level.points).pad_zeros(2)

## Shows the main menu and hides all other UI.
func show_menu():
	$MainMenu.visible = true
	$HUD.visible = false
	$Results.visible = false

## Shows the in-game HUD and hides all other UI.
func show_hud():
	$MainMenu.visible = false
	$HUD.visible = true
	$Results.visible = false

## Shows the result screen and hides all other UI.
func show_results():
	$MainMenu.visible = false
	$HUD.visible = false
	$Results.visible = true
	$Results/Score.text = String.num(level.points).pad_zeros(2)
