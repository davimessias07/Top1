class_name AppManager extends Node

static var app_data

static var account_controller
static var global_functions
static var load_scene_controller
static var scenes
static var http_manager

static var path_scenes = preload("res://Recursos/path_scenes.gd").new()
static var endpoint = preload("uid://bfpnhfq1b3jbh").new()
static var cache = preload("res://Recursos/cache.gd").new()

static var menu

static var current_scene = "res://Global/AppManager/app_manager.gd"

signal complete_set_nodes_reference

func _ready() -> void:
	connect_signals()
	set_nodes_reference()

func connect_signals():
	complete_set_nodes_reference.connect(complete_set_nodes)

func set_nodes_reference():
	global_functions = $GlobalFunctions
	account_controller = $AccountController
	load_scene_controller = $LoadSceneController
	scenes = $Scenes
	http_manager = $HTTPManager
	complete_set_nodes_reference.emit()

func complete_set_nodes():
	check_login()

func check_login():
	if account_controller.get_state_login():
		global_functions.get_remote_user_attrs(load_scene_controller.trade_scene.bind(path_scenes.MENU))
		print("Ta logado")
	else:
		account_controller.open_login_scene()
		print("Ta Deslogado")
