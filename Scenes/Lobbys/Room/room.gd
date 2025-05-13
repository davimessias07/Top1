extends MarginContainer
@onready var room_name: Control = $ScreenGridVertical/RoomName
@onready var host: Control = $ScreenGridVertical/Users/ScreenGridHorizontal/MarginContainer/HBoxContainer/Host
@onready var button_enter_room: Button = $ScreenGridVertical/Button

var data_room 

func set_room_attr(attrs):
	data_room = attrs
	button_enter_room.connect("pressed",enter_room)
	if attrs.value.has("name_room"):
		room_name.set_text(attrs.value.name_room)
	host.start_setup(AppManager.account_controller.data_user)

func enter_room():
	var db_ref = Firebase.Database.get_database_reference("Games/R6/lobbys/1vs1/rooms/" + data_room.value.name_room)
	db_ref.new_data_update.connect(new_data_updated)

func new_data_updated(data):
	var db_ref = Firebase.Database.get_database_reference("Games/R6/lobbys/1vs1/rooms/" + data_room.value.name_room + "/users")
	print("new_data_updated")
	print(data.data)
	
	db_ref.update("new",AppManager.account_controller.data_user)
