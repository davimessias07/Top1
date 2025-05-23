extends MarginContainer

@onready var text_label: Label = $Text_label
@export var default_font_size = 30

func set_text(new_text,font_size:int = default_font_size ):
	text_label.text = str(new_text)
	text_label.set("theme_override_font_sizes/font_size",font_size)
	show()

func clear_text():
	text_label.text = ""
	hide()
