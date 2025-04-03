extends TextureRect

@onready var button: Button = $Button
@onready var label_defaut: MarginContainer = $LabelDefaut

var mode_infos 

func set_attrs(attrs):
	mode_infos = attrs
	button.connect("pressed",btn_pressed)
	label_defaut.set_text(attrs.mode_name)

func btn_pressed():
	var scene = await AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.CREATE_OR_VIEW_LOBBYS)
	scene.data_mode = mode_infos
