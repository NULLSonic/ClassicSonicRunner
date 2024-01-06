extends Node2D

var nextScene = preload("res://scenes/Presentation/MainMenu.tscn")

func _ready():
	Global.changeTitle("Outdated Game. Please update!")
	$urVersion.text = Global.version
	$upToDate.text = Global.newVersion

func _process(_delta):
	if Input.is_key_pressed(KEY_ENTER):
		OS.shell_open("https://github.com/NULLSonic/ClassicSonicRunner")
		get_tree().quit()
	if Input.is_key_pressed(KEY_BACKSPACE):
		Global.main.changeScene(nextScene)
