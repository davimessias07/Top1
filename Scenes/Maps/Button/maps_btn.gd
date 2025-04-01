extends TextureRect

@onready var button: Button = $Button
@onready var label_defaut: MarginContainer = $LabelDefaut

var game_infos 

func set_attrs(name_item,attrs):
	game_infos = attrs
	button.connect("pressed",btn_pressed)
	label_defaut.set_text(name_item)

func btn_pressed():
	pass
