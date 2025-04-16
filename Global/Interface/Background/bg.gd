extends TextureRect

var Paths_default = preload("uid://bvbk024pxcxd8").new()

@export var disable_get_remote:bool = false

@export_enum("default","top_bar") var type:String = "default"

func _ready() -> void:
	if disable_get_remote == false:
		load_remote_image()
	else:
		var img_url = get_default()
		AppManager.global_functions.getRemoteImage(img_url,self)

func get_default() -> String:
	match type:
		"top_bar":
			return Paths_default.BG_TOP_BAR
	return Paths_default.BG_DEFAULT

func load_remote_image():
	var img_url = get_default()
	AppManager.global_functions.getRemoteImage(img_url,self)
