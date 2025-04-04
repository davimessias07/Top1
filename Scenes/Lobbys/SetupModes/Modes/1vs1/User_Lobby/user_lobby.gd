extends MarginContainer

@onready var user_image: TextureRect = $ScreenGridVertical/UserImage
@onready var username: MarginContainer = $ScreenGridVertical/Username

@export var font_size = 30

func start_setup(attrs):
	user_image.set_image(attrs.image)
	username.set_text(attrs.name,font_size)
