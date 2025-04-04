class_name GlobalGameplayStore extends Resource


var SAVE_PATH:String

func loadItem() -> Resource:
	if ResourceLoader.exists(SAVE_PATH):
		return load(SAVE_PATH)
	return self

func clear():
	if ResourceLoader.exists(SAVE_PATH):
		ResourceSaver.save(self, SAVE_PATH)

func save(jsonData: Dictionary) -> void:
	ResourceSaver.save(self, SAVE_PATH)
