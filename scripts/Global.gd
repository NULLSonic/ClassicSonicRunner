extends Node

var version = "0.0.0.2"
var newVersion = ""

var main = null
var soundtrack = null

var fadePlayer = null

var defaultTitle = "Classic Sonic Runners"

func changeTitle(title = ""):
	if title != "":
		get_window().title = defaultTitle + " | " + title
	else:
		get_window().title = defaultTitle
