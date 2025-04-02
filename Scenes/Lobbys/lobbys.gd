extends Control

var player_id = ""
var db_ref = Firebase.Database.get_database_reference("Games/R6/lobbys/1vs1")
var data_infos

const ROOM = preload("uid://b4tjhants4q80")
@onready var grid_container: GridContainer = $BaseModal/BG/ScreenGridVertical/ScreenGridHorizontal/Content/ScrollContainer/MarginContainer/GridContainer


func _ready() -> void:
	player_id = Firebase.Auth.auth.localid
	#db_ref.new_data_update.connect(new_data_updated)
	#db_ref.patch_data_update.connect(patch_data_updated)

func new_data_updated(data):
	print("new_data_updated")
	print(data)
	result(data)

func patch_data_updated(data):
	print("patch_data_updated")
	print(data)


func instance_lobbys():
	var path = "Games/R6/lobbys/1vs1"
	var room_db = Firebase.Database.get_database_reference(path)
	room_db.new_data_update.connect(new_data_updated)


func result(data_teste):
	var arr:Array
	for chave in data_teste.data.keys():
		if chave != "id_room":
			arr.append({"key": chave, "value": data_teste.data[chave]})
	
	for room in arr:
		var room_scn = ROOM.instantiate()
		grid_container.add_child(room_scn)
		room_scn.set_room_attr(room)
