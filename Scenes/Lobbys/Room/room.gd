extends Panel
@onready var room_name: MarginContainer = $ScreenGridVertical/RoomName
@onready var host: MarginContainer = $ScreenGridVertical/Users/ScreenGridHorizontal/Host
#@onready var user_2: MarginContainer = $ScreenGridVertical/Users/ScreenGridHorizontal/User2


func set_room_attr(attrs):
	room_name.set_text(attrs.value.name_room)
	host.start_setup(AppManager.account_controller.data_user)
	#user_2.username.set_text("Procurando Jogadores...",10)
