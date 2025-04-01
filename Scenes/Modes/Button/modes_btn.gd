extends TextureRect

@onready var button: Button = $Button
@onready var label_defaut: MarginContainer = $LabelDefaut

var mode_infos 

func set_attrs(name_item,attrs):
	mode_infos = attrs
	button.connect("pressed",btn_pressed)
	label_defaut.set_text(name_item)

func btn_pressed():
	var scene = await AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.CREATE_OR_VIEW_LOBBYS)
	
