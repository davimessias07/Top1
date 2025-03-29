extends Node
class_name JsonResponse

func getData(data):
	var responseJson = JSON.new()
	responseJson.parse(data.get_string_from_utf8())
	return responseJson.get_data()


"""
Quando o json é uma string
"""


func getDictionaryFromString(dataString: String) -> Dictionary:
	var responseJson = JSON.new()
	responseJson.parse(dataString)
	return responseJson.get_data()

func openFileJsonDictionary(filePath: String):
	
	return openFile(filePath)

func openFile(filePath: String):
	var dictionary = Dictionary()
	var dataFile = FileAccess.open(filePath, FileAccess.READ)

	#print(dataFile.get_as_text())
	var json_object = JSON.new()
	json_object.parse(dataFile.get_as_text())
	dictionary = json_object.get_data()
	return dictionary



#static func requestHasError(json)->bool:
#if isDisconnected(json) || isSuccess(json):
#
#


func isDisconnected(json) -> bool:
	return json != null and json.has("disconnect") and json.get("disconnect") == true


func getMsg(json, defaultMsg) -> String:
	var msg = ""
	if json != null and json.has("msg"):
		msg = json.get("msg")
	if msg == "":
		msg = defaultMsg
	return msg


func isSuccess(json) -> bool:
	return json != null and json.has("success") and json.get("success") == true
