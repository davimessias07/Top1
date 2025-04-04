extends Panel
@onready var room_name: MarginContainer = $ScreenGridVertical/RoomName
@onready var host_lobby: MarginContainer = $ScreenGridVertical/Users/ScreenGridHorizontal/user_lobby

func set_room_attr(attrs):
	room_name.set_text(attrs.value.name_room)
	host_lobby.start_setup(AppManager.account_controller.data_user)
