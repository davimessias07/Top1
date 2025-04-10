extends Control

@onready var create_lobby: Button = $Body/ScreenGridHorizontal/CreateLobby
@onready var view_lobbys: Button = $Body/ScreenGridHorizontal/ViewLobbys

var player_id = ""
var data_mode 

func set_data_mode(data_info):
	data_mode = data_info
	set_buttons()

func _ready() -> void:
	player_id = Firebase.Auth.auth.localid

func new_data_updated(data):
	print("new_data_updated")
	print(data)

func patch_data_updated(data):
	print("patch_data_updated")
	print(data)

func set_buttons():
	create_lobby.connect("pressed",create_room)
	view_lobbys.connect("pressed",instance_room_view)

func create_room():
	var db_ref = Firebase.Database.get_database_reference("Games/R6/lobbys/1vs1/rooms")
	db_ref.new_data_update.connect(new_data_updated)
	db_ref.patch_data_update.connect(patch_data_updated)
	
	var type_room = data_mode.mode_name
	
	var room_attrs = {
		"id_room":0,
		"name_room": AppManager.account_controller.data_user.name,
		"type":type_room
	}
	
	await db_ref.update(player_id,room_attrs)
	
	instance_room(data_mode.mode_name)

func instance_room(type_mode):
	var args = {
		"parent_scene":AppManager.menu.body,
		"action_complete":{"action":"check_type_room","action_args":type_mode}
	}
	
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.LOBBYS,args)

func instance_room_view():
	var args = {
		"parent_scene":AppManager.menu.body,
		"action_complete":{"action":"instance_lobbys"}
	}
	
	AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.LOBBYS,args)
