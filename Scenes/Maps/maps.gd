extends MarginContainer

const MAPS_BTN = preload("uid://bgvuih6eslyun")
@onready var screen_grid_horizontal: HBoxContainer = $BG/ScreenGridVertical/Scroll/ScreenGridHorizontal


func get_all_maps(all_maps):
	for map in all_maps:
		var scene = MAPS_BTN.instantiate()
		screen_grid_horizontal.add_child(scene)
		scene.set_attrs(map.map_name,map)
