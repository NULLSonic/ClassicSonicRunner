extends Node2D

@onready var transitions = $transitions

func _ready():
	await Global.fadePlayer.animation_finished
	transitions.play("transition")
