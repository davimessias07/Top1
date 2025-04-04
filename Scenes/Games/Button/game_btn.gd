extends Button
@onready var label_defaut: MarginContainer = $Panel/LabelDefaut

var game_infos 

func set_attrs(attrs):
	game_infos = attrs
	connect("pressed",btn_pressed)
	label_defaut.set_text(attrs.game_name)

func btn_pressed():
	var scene = await AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MODES,func():pass,AppManager.menu.body)
	scene.get_all_modes(game_infos.modes)
