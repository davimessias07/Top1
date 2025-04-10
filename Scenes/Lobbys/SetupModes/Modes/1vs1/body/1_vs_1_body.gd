extends Control

@onready var host: Control = $Content/ScreenGridVertical/Users/ScreenGridHorizontal/Host
@onready var user_2: Control = $Content/ScreenGridVertical/Users/ScreenGridHorizontal/User2

func set_host_attrs():
	host.start_setup(AppManager.account_controller.data_user)
	user_2.username.set_text("Procurando...")
