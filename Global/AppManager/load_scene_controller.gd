extends Node

func clear():
	for child in AppManager.scenes.get_children():
		if child:
			child.queue_free()

func trade_scene(new_scene:String,action:Callable = func ():):
	clear()
	var scene = load(new_scene).instantiate()
	AppManager.scenes.add_child(scene)
	action.call()
	return scene

func load_scene(new_scene:String,action:Callable = func ():,parent = AppManager.scenes):
	var scene = load(new_scene).instantiate()
	parent.add_child(scene)
	action.call()
