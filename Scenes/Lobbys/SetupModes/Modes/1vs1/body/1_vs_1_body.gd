extends Control

@onready var host: Control = $Content/ScreenGridVertical/Users/ScreenGridHorizontal/Host
@onready var user_2: Control = $Content/ScreenGridVertical/Users/ScreenGridHorizontal/User2
@onready var btn_state_room: Button = $Content/ScreenGridVertical/btnStateRoom

func set_host_attrs():
	host.start_setup(AppManager.account_controller.data_user)
	user_2.username.set_text("Inimigo")

func set_room_state(new_state):
	match new_state:
		"seeking":
			set_seeking()

func set_seeking():
	btn_state_room.text = "Esperando Jogador..."
	btn_state_room.disabled = true
