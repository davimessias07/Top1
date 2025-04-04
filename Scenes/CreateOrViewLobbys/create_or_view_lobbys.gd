extends Control

@onready var create_lobby: MarginContainer = $Body/ScreenGridHorizontal/CreateLobby
@onready var view_lobbys: MarginContainer = $Body/ScreenGridHorizontal/ViewLobbys

var player_id = ""
var db_ref = Firebase.Database.get_database_reference("Games/R6/lobbys/1vs1/rooms")
var data_mode 

func set_data_mode(data_info):
	data_mode = data_info
	set_buttons()

func _ready() -> void:
	player_id = Firebase.Auth.auth.localid
	db_ref.new_data_update.connect(new_data_updated)
	db_ref.patch_data_update.connect(patch_data_updated)

func new_data_updated(data):
	print("new_data_updated")
	print(data)

func patch_data_updated(data):
	print("patch_data_updated")
	print(data)

func set_buttons():
	create_lobby.button.connect("pressed",create_room)
	view_lobbys.button.connect("pressed",instance_room_view)

func create_room():
	var type_room = data_mode.mode_name
	
	var room_attrs = {
		"id_room":0,
		"name_room": AppManager.account_controller.data_user.name,
		"type":type_room
	}
	
	await db_ref.update(player_id,room_attrs)
	
	instance_room(data_mode.mode_name)

func instance_room(type_mode):
	var scene = await AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.LOBBYS)
	scene.check_type_room(type_mode)

func instance_room_view():
	var scene = await AppManager.load_scene_controller.trade_scene(AppManager.path_scenes.LOBBYS,func():pass,AppManager.menu.body)
	scene.instance_lobbys()
