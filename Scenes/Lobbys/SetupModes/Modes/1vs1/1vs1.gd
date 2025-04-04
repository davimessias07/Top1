extends Node

const BODY = "uid://bk5pwcaa0fm6u"

func set_setup(parent_instance_setup):
	var scene = await AppManager.load_scene_controller.load_scene(BODY,func():pass,parent_instance_setup)
	scene.set_host_attrs()

#func instance_lobbys():
	#var path = "Games/R6/lobbys/1vs1"
	#var room_db = Firebase.Database.get_database_reference(path)
	#room_db.new_data_update.connect(new_data_updated)
	#room_db.patch_data_update.connect(patch_data_updated)

#func result(data_teste):
	#var arr:Array
	#for chave in data_teste.data.keys():
		#arr.append({"key": chave, "value": data_teste.data[chave]})
	#
	#for room in arr:
		#var room_scn = ROOM.instantiate()
		#grid_container.add_child(room_scn)
		#room_scn.set_room_attr(room)
