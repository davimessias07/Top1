extends Control

@onready var host: MarginContainer = $Content/Users/ScreenGridHorizontal/Host
@onready var user_2: MarginContainer = $Content/Users/ScreenGridHorizontal/User2

func set_host_attrs():
	host.start_setup(AppManager.account_controller.data_user)
	user_2.username.set_text("Procurando Jogadores...")
