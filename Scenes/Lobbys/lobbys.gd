extends MarginContainer

var player_id = ""
var db_ref = Firebase.Database.get_database_reference("Games/R6/lobbys/1vs1")
var data_infos

var current_grid

@onready var margin_content: MarginContainer = $ScreenGridHorizontal/Content/ScrollContainer/MarginContainer

const ROOM = preload("uid://b4tjhants4q80")
var setup_modes = preload("uid://by7tox41fb6gw").new()

func _ready() -> void:
	player_id = Firebase.Auth.auth.localid

func new_data_updated(data):
	print("new_data_updated")
	print(data)
	result(data)

func patch_data_updated(data_new):
	print("patch_data_updated")
	print(data_new)
	update(data_new.data)

func check_type_room(type):
	match type:
		"1vs1":
			setup_modes._1vs1.set_setup(margin_content)

func instance_lobbys():
	var path = "Games/R6/lobbys/1vs1"
	var room_db = Firebase.Database.get_database_reference(path)
	room_db.new_data_update.connect(new_data_updated)
	room_db.patch_data_update.connect(patch_data_updated)


func result(data_teste):
	var arr:Array
	
	if margin_content.get_child_count() > 0:
		for child in margin_content.get_children():
			child.queue_free()
	
	for chave in data_teste.data.keys():
		arr.append({"key": chave, "value": data_teste.data[chave]})
	
	current_grid = GridContainer.new()
	current_grid.columns = 3
	current_grid.set("theme_override_constants/v_separation",50)
	current_grid.set("theme_override_constants/h_separation",50)
	
	margin_content.add_child(current_grid)
	
	for room in arr:
		var room_scn = ROOM.instantiate()
		current_grid.add_child(room_scn)
		room_scn.set_room_attr(room)

func update(data_teste):
	var new_room = {"value": data_teste}
	
	var room_scn = ROOM.instantiate()
	current_grid.add_child(room_scn)
	room_scn.set_room_attr(new_room)
