extends Node

func clear(parent):
	for child in parent.get_children():
		if child:
			child.queue_free()

func trade_scene(new_scene:String,action:Callable = func ():,parent = AppManager.scenes):
	if AppManager.current_scene != new_scene:
		clear(parent)
		AppManager.current_scene = new_scene
		var scene = load(new_scene).instantiate()
		parent.add_child(scene)
		action.call()
		return scene

func load_scene(new_scene:String,action:Callable = func ():,parent = AppManager.scenes):
	if AppManager.current_scene != new_scene:
		var scene = load(new_scene).instantiate()
		AppManager.current_scene = new_scene
		parent.add_child(scene)
		action.call()
		return scene
