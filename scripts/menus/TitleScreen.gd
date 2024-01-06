extends Node2D

@onready var intro_player = $introPlayer

@export var nextScene = preload("res://scenes/Presentation/MainMenu.tscn")

@onready var http_request = $HTTPRequest

var curVersion = ""

func _ready():
	$Sega.visible = true
	$Title.visible = false
	intro_player.play("sega")
	
	http_request.request_completed.connect(update)
	var error = http_request.request("https://raw.githubusercontent.com/NULLSonic/ClassicSonicRunner/main/version.txt")
	if error != OK:
		push_error("Something went wrong with the HTTP Request!")

func _process(_delta):
	if Global.version != curVersion:
		nextScene = preload("res://scenes/Presentation/OutdatedMenu.tscn")
	
	if intro_player.current_animation != "":
		if intro_player.current_animation == "sega":
			Global.changeTitle("Credits Intro")
		elif intro_player.current_animation_position >= 10.5 and intro_player.current_animation == "titleAnim":
			Global.changeTitle("Title")
	
	if Input.is_action_just_pressed("gm_start"):
		if intro_player.current_animation_position >= 15 and intro_player.current_animation == "titleAnim":
			intro_player.stop()
			$AudioStreamPlayer.stop()
			Global.soundtrack.play()
			Global.main.changeScene(nextScene)
		elif intro_player.current_animation == "sega":
			$Sega.visible = false
			$Title.visible = true
			intro_player.play("titleAnim")

func _on_intro_player_animation_finished(anim_name):
	if anim_name == "sega":
		$Sega.visible = false
		$Title.visible = true
		intro_player.play("titleAnim")
	if anim_name == "titleAnim":
		Global.soundtrack.play()
		Global.main.changeScene(nextScene)

func update(result, _response_code, _headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("shit is borken")
	print(body.get_string_from_utf8())
	curVersion = str(body.get_string_from_utf8())
	Global.newVersion = curVersion
