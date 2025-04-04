extends Button

@onready var label_defaut: MarginContainer = $Panel/LabelDefaut

@export var description:String
@export var font_size_description:int = 30

func _ready() -> void:
	set_setup()

func set_setup():
	label_defaut.set_text(description,font_size_description)
