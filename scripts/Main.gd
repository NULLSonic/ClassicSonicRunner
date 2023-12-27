extends Node2D

func _ready():
	Global.main = self
	Global.soundtrack = get_node_or_null("Audio/Soundtrack")

func _input(event):
	if event.is_action_released("gm_fullscreen"):
		if get_window().mode == Window.MODE_WINDOWED:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED

func changeScene():
	pass
