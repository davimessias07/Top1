extends MarginContainer

@onready var text_label: Label = $Text_label

func set_text(new_text:String):
	text_label.text = new_text
	show()

func clear_text():
	text_label.text = ""
	hide()
