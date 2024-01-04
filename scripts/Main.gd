extends Node2D

@onready var fade_player = $GUI/Fade/fadePlayer
@onready var volumeTxt = $GUI/Volume/Panel/volumeTxt
@onready var volumeSlider = $GUI/Volume/slideIn
@onready var volumeTimer = $GUI/Volume/volumeTimer

var volumePanelOpen = false

func _ready():
	Global.main = self
	Global.soundtrack = get_node_or_null("Audio/Soundtrack")
	Global.fadePlayer = get_node_or_null("GUI/Fade/fadePlayer")

func _process(_delta):
	volumeTxt.text = str(AudioServer.get_bus_volume_db(0)) + "dB"

func _input(event):
	if event.is_action_released("gm_fullscreen"):
		if get_window().mode == Window.MODE_WINDOWED:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED
			
	if event.is_action_released("gm_volume_down"):
		if !volumePanelOpen:
			volumePanelOpen = true
			volumeSlider.play("slide")
			
		if AudioServer.get_bus_volume_db(0) - 10 >= -80:
			AudioServer.set_bus_volume_db(0, AudioServer.get_bus_volume_db(0) - 10)
		
		await volumeSlider.animation_finished
		volumeTimer.start()
	
	
	if event.is_action_released("gm_volume_up"):
		if !volumePanelOpen:
			volumePanelOpen = true
			volumeSlider.play("slide")
			
		if AudioServer.get_bus_volume_db(0) < 0:
			AudioServer.set_bus_volume_db(0, AudioServer.get_bus_volume_db(0) + 10)
		
		await volumeSlider.animation_finished
		volumeTimer.start()

func changeScene(file = ""):
	fade_player.play("fade")
	await fade_player.animation_finished
	
	$SceneLoader.get_child(0).queue_free()
	var instance = file.instantiate()
	
	$SceneLoader.add_child(instance)
	
	fade_player.play_backwards("fade")



func _on_volume_timer_timeout():
	volumePanelOpen = false
	volumeSlider.play_backwards("slide")
