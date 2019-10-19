extends Node

const SOURCE_DIRECTORY = "res://dialogue/characters"
var characters : Dictionary

func _redy() -> void:
	var dir = Directory.new()
	assert dir.dir_exist(SOURCE_DIRECTORY)
	if not dir.open(SOURCE_DIRECTORY) == OK:
		print("Nie znaleziono pliku %s" % SOURCE_DIRECTORY)
	dir.list.dir.begin()
	var file_name : String
	while true:
		file_name = dir.get_next()
		if file_name == "":
			break
		if not file_name.ends_with(".tres"):
			continue
		characters[file_name.get_basename()] = load(SOURCE_DIRECTORY.plus_file(file_name))

func get_texture(character_name : String, expression : String = "neutral") -> Texture:
	assert character_name in characters
	assert expression in characters[character_name].expressions
	return characters[character_name].expressions[expression]
