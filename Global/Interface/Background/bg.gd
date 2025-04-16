extends TextureRect

var PathsBg = preload("uid://bvbk024pxcxd8").new()

@export var disable_get_remote:bool = false

@export_enum("default","top_bar") var type:String = "default"

func _ready() -> void:
	if disable_get_remote == false:
		load_remote_image()

func get_bg() -> String:
	match type:
		"top_bar":
			return PathsBg.BG_TOP_BAR
	
	return PathsBg.BG_DEFAULT

func load_remote_image():
	var img_url = get_bg()
	AppManager.global_functions.getRemoteImage(img_url,self)
