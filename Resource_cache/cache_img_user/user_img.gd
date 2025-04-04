extends Resource
class_name UserImg

@export var current_account_image_path = ""

func write_all() -> void:
	ResourceSaver.save(self, AppManager.cache.cache_img_user)
