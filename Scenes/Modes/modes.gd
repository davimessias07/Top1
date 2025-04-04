extends MarginContainer

@onready var name_screen: MarginContainer = $ScreenGridVertical/NameScreen
const MODES_BTN = preload("uid://cfdgpsufghyd4")
@onready var screen_grid_horizontal: HBoxContainer = $ScreenGridVertical/Scroll/ScreenGridHorizontal

@export var screen_name:String
@export var screen_name_font_size:int = 30

func get_all_modes(all_modes):
	set_name_screen()
 
	for mode in all_modes:
		var scene = MODES_BTN.instantiate()
		screen_grid_horizontal.add_child(scene)
		scene.set_attrs(mode)

func set_name_screen():
	name_screen.set_text(screen_name,screen_name_font_size)
