extends Node2D

@onready var intro_player = $introPlayer

@export var nextScene = preload("res://scenes/Presentation/MainMenu.tscn")

func _ready():
	$Sega.visible = true
	$Title.visible = false
	intro_player.play("sega")

func _on_intro_player_animation_finished(anim_name):
	if anim_name == "sega":
		$Sega.visible = false
		$Title.visible = true
		intro_player.play("titleAnim")
	if anim_name == "titleAnim":
		Global.soundtrack.play()
		Global.main.changeScene(nextScene)
