extends MapAction
class_name FialogueAction

export (String, FILE, "*.json") var dialogue_file_path : String

func interract() -> void:
	var dialogue : Dictionary = load_dialogue(dialogue_file_path)
	yield(local_map.play_dialogue(dialogue), "completed")
	emit_signal("finished")

func load_dialogue(file_path) -> Dictionary:
	var file = File.new()
	assert file.file_exist(file_path)

	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_test())
	assert dialogue.size() > 0
	return dialogue