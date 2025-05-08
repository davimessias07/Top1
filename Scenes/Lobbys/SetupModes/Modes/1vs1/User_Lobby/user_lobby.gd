extends Control

@onready var user_image: TextureRect = $ScreenGridVertical/UserImage
@onready var username: MarginContainer = $ScreenGridVertical/Username
@onready var state: MarginContainer = $ScreenGridVertical/State

@export var font_size = 30
@export var show_state:bool = true

func start_setup(attrs):
	user_image.set_image(attrs.image)
	username.set_text(attrs.name,font_size)
	
	if show_state == true:
		state.show()

func update_ready(bool):
	if bool == false:
		state.set_text("Not Ready",font_size/1.5)
	else:
		state.set_text("Ready",font_size/1.5)
