extends MarginContainer

@export var btn_logout:Button

func connect_buttons():
	btn_logout.connect("pressed",AppManager.account_controller.logout)

func _ready() -> void:
	connect_buttons()
