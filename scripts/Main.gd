extends Node2D

@onready var fade_player = $GUI/Fade/fadePlayer

func _ready():
	Global.main = self
	Global.soundtrack = get_node_or_null("Audio/Soundtrack")
	Global.fadePlayer = get_node_or_null("GUI/Fade/fadePlayer")

func _input(event):
	if event.is_action_released("gm_fullscreen"):
		if get_window().mode == Window.MODE_WINDOWED:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED

func changeScene(file = ""):
	fade_player.play("fade")
	await fade_player.animation_finished
	
	$SceneLoader.get_child(0).queue_free()
	var instance = file.instantiate()
	
	$SceneLoader.add_child(instance)
	
	fade_player.play_backwards("fade")

