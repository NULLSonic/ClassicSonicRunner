@tool

@icon("res://assets/img/customNodes/keyButton.png")

class_name KeyButton
extends Node2D

@onready var bg = $BG

@export_category("Key Button")
@export var size = Vector2(128, 128)

@export var bgColor = Color8(0, 0, 0, 255)
@export var borderColor = Color8(0, 0, 0, 255)

@export var borderWidth = Vector4(4, 4, 4, 4)
@export var cornerRadius = Vector4(8, 8, 8, 8)

func _process(_delta):
	if Engine.is_editor_hint():
		setBox()
	else:
		setBox()

func setBox():
	bg.size = size
	var newPosX = bg.size.x / 2
	var newPosY = bg.size.y / 2
	bg.position = Vector2(0 - newPosX, 0 - newPosY)
	
	var theme = StyleBoxFlat.new()
	
	theme.bg_color = bgColor

	bg.add_theme_stylebox_override("Panel", theme)
