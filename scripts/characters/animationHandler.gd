extends Node2D

@onready var animator = $introPlayer


func playAnim(anim = ""):
	animator.play(anim)

