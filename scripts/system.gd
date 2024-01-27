## Handles system inputs.
class_name Sys extends Node

## Handles input logic.
func _process(delta):
	# Closes the game on desktop
	if Input.is_action_just_pressed("ui_cancel") && OS.get_name() != "Web":
		get_tree().quit()
		return
	
	# Toggles between fullscreen and windowed mode
	if Input.is_action_just_pressed("ui_fullscreen"):
		if get_window().mode == Window.MODE_WINDOWED:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED

## Pauses the music if user switched tabs in browser.
func _notification(what):
	if OS.get_name() != "Web":
		return
	
	# BUG: FOCUS_IN and FOCUS_OUT do not get detected when switching tabs
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		Music.instance.stream_paused = false
	elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		Music.instance.stream_paused = true
