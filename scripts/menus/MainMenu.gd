extends Node2D

@onready var transitions = $transitions
@onready var max_button = $Overlay/BG/Decorations/button/maxButton

@onready var exitYes = $Overlay/BG/Panel/yes
@onready var exitNo = $Overlay/BG/Panel/no

@onready var version = $BG/Label

var maxTexture = [preload("res://assets/img/menus/mainMenu/pad/max.png"), preload("res://assets/img/menus/mainMenu/pad/small.png")]

var inMaxMode = false
var exiting = false

var curSelected = 0

func _ready():
	await Global.fadePlayer.animation_finished
	transitions.play("transition")

func _process(delta):
	version.text = "VERSION: " + Global.version
	if exiting:
		if Input.is_action_just_released("gm_right"):
			if curSelected + 1 > 1:
				curSelected = 0
				exitYes.modulate = Color8(255, 255, 0, 255)
				exitNo.modulate = Color8(255, 255, 255, 205)
			else:
				exitYes.modulate = Color8(255, 255, 255, 205)
				exitNo.modulate = Color8(255, 255, 0, 255)
				curSelected += 1
		if Input.is_action_just_released("gm_left"):
			if curSelected - 1 < 0:
				curSelected = 1
				exitYes.modulate = Color8(255, 255, 255, 205)
				exitNo.modulate = Color8(255, 255, 0, 255)
			else:
				curSelected = curSelected - 1
				exitYes.modulate = Color8(255, 255, 255, 205)
				exitNo.modulate = Color8(255, 255, 0, 255)
		if Input.is_action_just_released("gm_start"):
			if curSelected == 0:
				Global.fadePlayer.play("fadeIn")
				await Global.fadePlayer.animation_finished
				get_tree().quit()
			else:
				exiting = false
				transitions.play_backwards("showExit")

func _on_max_button_pressed():
	if get_window().mode == Window.MODE_WINDOWED:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	else:
		if inMaxMode:
			inMaxMode = false
			max_button.texture_normal = maxTexture[0]
			transitions.play_backwards("maxPad")
		else:
			inMaxMode = true
			max_button.texture_normal = maxTexture[1]
			transitions.play("maxPad")


func _on_x_button_pressed():
	exiting = true
	transitions.play("showExit")


func _on_hide_button_pressed():
	if get_window().mode == Window.MODE_WINDOWED:
		get_window().mode = Window.MODE_MINIMIZED
	#Global.soundtrack.stop()
	#Global.main.changeScene(preload("res://scenes/Presentation/TitleScreen.tscn"))
