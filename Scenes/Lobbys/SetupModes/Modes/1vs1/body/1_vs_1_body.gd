extends MarginContainer

@onready var host: MarginContainer = $Content/Users/ScreenGridHorizontal/Host

func set_host_attrs():
	host.start_setup(AppManager.account_controller.data_user)
