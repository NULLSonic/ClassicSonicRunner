extends Node2D

@onready var transitionsPlayer = $transitions
@onready var maxButton = $sonPad/tabBar/HBoxContainer/max
@onready var s1 = $S1
@onready var sonic_animator = $sonicAnimator

var maxWindow = false
var maxIcons = [preload("res://assets/img/menus/mainMenu/pad/max.png"), preload("res://assets/img/menus/mainMenu/pad/min.png")]

func _ready():
	Global.changeTitle("Main Menu")
	s1.playAnim("run")
	s1.setAnimSpeed(2)
	sonic_animator.play("runScreen")
	await Global.fadePlayer.animation_finished
	transitionsPlayer.play("slideIn")
