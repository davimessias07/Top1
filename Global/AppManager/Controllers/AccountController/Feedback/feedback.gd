extends MarginContainer

@onready var feedback_panel: Panel = $Feedback_panel
@onready var feedback_label: MarginContainer = $Feedback_label

func show_feedback(new_text:String,color_label:Color,action:Callable = func():):
	set_panel_color(color_label)
	feedback_label.set_text(new_text)
	await get_tree().create_timer(2).timeout
	action.call()

func set_panel_color(new_color):
		feedback_panel.self_modulate = new_color
		feedback_panel.show()

func hide_feedback():
	feedback_label.clear_text()
	feedback_panel.hide()
