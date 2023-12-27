extends Node2D

@onready var fade_player = $GUI/Fade/fadePlayer
@onready var http_request = $HTTPRequest

func _ready():
	http_request.request_completed.connect(update)
	var error = http_request.request("https://github.com/NULLSonic/ClassicSonicRunner/blob/main/version.txt")
	if error != OK:
		push_error("Something went wrong with the HTTP Request!")
		
	Global.main = self
	Global.soundtrack = get_node_or_null("Audio/Soundtrack")
	Global.fadePlayer = get_node_or_null("GUI/Fade/fadePlayer")

func _input(event):
	if event.is_action_released("gm_fullscreen"):
		if get_window().mode == Window.MODE_WINDOWED:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED

func changeScene(file = ""):
	fade_player.play("fadeIn")
	await fade_player.animation_finished
	
	$SceneLoader.get_child(0).queue_free()
	var instance = file.instantiate()
	
	$SceneLoader.add_child(instance)
	
	fade_player.play("fadeOut")
	
func update(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("shit is borken")
	print(body)
