extends Button
@onready var label_defaut: MarginContainer = $Panel/LabelDefaut

var game_infos 

func set_attrs(attrs):
	game_infos = attrs
	connect("pressed",btn_pressed)
	label_defaut.set_text(attrs.game_name)

func btn_pressed():
	var args = {
		"parent_scene":AppManager.menu.body,
		"action_complete":{"action":"get_all_modes","action_args":game_infos.modes}
	}
	
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.MODES,args)
