@tool
@icon("res://assets/img/customNodes/keyButton.png")

class_name KeyButton
extends Node2D
## Node to create Keyboard and Controller Buttons.

@onready var bg = $BG
@onready var label = $Txt

@export_category("Background")
@export var size = Vector2(128, 128)

@export var bgColor = Color8(255, 255, 255, 255)
@export var borderColor = Color8(0, 0, 0, 255)

@export var borderWidth = Vector4(8, 8, 8, 8)
@export var cornerRadius = Vector4(16, 16, 16, 16)

@export_category("Text")

@export var textEnabled = true
@export var txtText = ""

@export var txtFont = preload("res://assets/fonts/NiseSegaSonic.TTF")
@export var fontSize = 64
@export var fontColor = Color8(255, 255, 255, 255)

@export var outlineSize = 32
@export var outlineColor = Color8(0, 0, 0, 255)

@export var shadowSize = 32
@export var shadowColor = Color8(0, 0, 0, 140)
@export var shadowOffset = Vector2(1, 4)

@export_category("Icon")
@export var iconEnabled = false
@export var icon = preload("res://assets/img/customNodes/keyButton.png") # Example Icon

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
	theme.border_color = borderColor
	
	theme.border_width_left = borderWidth[0]
	theme.border_width_top = borderWidth[1]
	theme.border_width_right = borderWidth[2]
	theme.border_width_bottom = borderWidth[3]
	
	theme.corner_radius_top_left = cornerRadius[0]
	theme.corner_radius_top_right = cornerRadius[1]
	theme.corner_radius_bottom_right = cornerRadius[2]
	theme.corner_radius_bottom_left = cornerRadius[3]
	
	bg.add_theme_stylebox_override("panel", theme)
	
	label.size = Vector2(bg.size.x - 32, bg.size.y - 32)
	var newLabelPosX = label.size.x / 2
	var newLabelPosY = label.size.y / 2
	label.position = Vector2(0 - newLabelPosX, 0 - newLabelPosY)
	
	label.visible = textEnabled
	label.text = str(txtText)
	
	var labelSetting = LabelSettings.new()
	
	# Font
	labelSetting.font = txtFont
	labelSetting.font_size = fontSize
	labelSetting.font_color = fontColor
	
	# Outline
	labelSetting.outline_size = outlineSize
	labelSetting.outline_color = outlineColor
	
	# Shadow (the hedgehog)
	labelSetting.shadow_size = shadowSize
	labelSetting.shadow_color = shadowColor
	labelSetting.shadow_offset = shadowOffset
	
	# Apply the label settings
	label.label_settings = labelSetting

