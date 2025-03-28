class_name AppManager extends Node

static var account_controller
static var load_scene_controller
static var scenes

static var path_scenes = preload("res://Recursos/path_scenes.gd").new()

signal complete_set_nodes_reference

func _ready() -> void:
	connect_signals()
	set_nodes_reference()

func connect_signals():
	complete_set_nodes_reference.connect(complete_set_nodes)

func set_nodes_reference():
	account_controller = $AccountController
	load_scene_controller = $LoadSceneController
	scenes = $Scenes
	complete_set_nodes_reference.emit()

func complete_set_nodes():
	if account_controller.get_state_login():
		load_scene_controller.trade_scene(path_scenes.MENU)
	else:
		account_controller.open_login_scene()
