extends Node


signal data_info_loaded


## Dicctionary containing all meta information on the S3 files.
## 
## Example: A file stored as '/some/arbitrary/folders/sample.png' will be contained as
## {"some": {"arbitrary": {"folders": {"sample.png": {"path": "<url to retrieve this file>", "size": <file size>} }}}}
var _data_info := {}

## If true, it is safe to request data through the provided methods.
var is_data_info_loaded := false


## Get all available names of images in the repository.
func get_image_names() -> Array:
	# Our AWS bucket is setup with the folder /data/images
	if not _data_info.has("data") or not _data_info["data"].has("images"):
		return []
	var name_list = []
	for image_name in _data_info["data"]["images"]:
		# On AWS buckets the folders get their own xml entry -> image with empty name gets parsed
		# This if statement is not necessary with linode object storage
		if image_name != "":
			name_list.push_back(image_name)
	return name_list


## Get web path for image name
func get_image_path(name: String) -> String:
	if not _data_info["data"]["images"].has(name):
		printerr("DataRepository: No image named %s exists." % name);
		return ""
	return _data_info["data"]["images"][name]["path"]


## Get the image with the associated name.
## Since this is an async operation, the caller must wait for the "completed" signal.
##
## Usage: var image = await DataRepository.get_image(name).completed
func get_image(name: String):
	if not _data_info["data"]["images"].has(name):
		printerr("DataRepository: No image named %s exists." % name);
		return null
	
	var error = $HTTPRequest.request(_data_info["data"]["images"][name]["path"])
	var response = await $HTTPRequest.request_completed 
	if error != OK:
		return null 
	
	# request_completed emits result, response_code, headers and body
	# we are only interested in body -> index 3
	var body = response[3]
	var image = Image.new()
	var image_type = name.split(".")[-1]
	# For now we only accept png, jpg and bmp images
	match image_type:
		"png": error = image.load_png_from_buffer(body)
		"jpg", "jpeg": error = image.load_jpg_from_buffer(body)
		"bmp": error = image.load_bmp_from_buffer(body)
		_: 
			printerr("DataRepository: Unsupported image type '%s' for image '%s'" % [image_type, name])
			error = FAILED
	if error != OK:
		return null
	return image
