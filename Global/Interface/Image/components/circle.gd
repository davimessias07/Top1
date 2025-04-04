extends TextureRect
@onready var image_user: TextureRect = $MarginContainer/ImageUser

func set_image(new_image):
	AppManager.global_functions.getRemoteImage(new_image,image_user)
