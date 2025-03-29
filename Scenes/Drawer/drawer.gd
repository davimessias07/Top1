extends MarginContainer

@export var btn_logout:Button
@onready var label_defaut: MarginContainer = $ScreenGridVertical/Body/ScreenGridVertical/LabelDefaut

func connect_buttons():
	btn_logout.connect("pressed",AppManager.account_controller.logout)

func _ready() -> void:
	connect_buttons()
	label_defaut.set_text(AppManager.account_controller.json_user.name)
