extends Control

@onready var name_user: MarginContainer = $Margin/ScreenGridVertical/Username/Name
@onready var balance: MarginContainer = $Margin/ScreenGridVertical/Balance/balance

func _ready() -> void:
	if AppManager.account_controller.data_user:
		name_user.set_text(AppManager.account_controller.data_user.name)
		balance.set_text("R$ " + str(AppManager.account_controller.data_user.balance))
