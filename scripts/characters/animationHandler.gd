extends Node2D

@onready var animator = $Animator

func playAnim(anim = ""):
	animator.play(anim)
	
func setAnimSpeed(speed = 1):
	animator.speed_scale = speed

