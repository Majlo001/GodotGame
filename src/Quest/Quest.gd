extends Node


onready var quest_folder = "res://src/Quest/quests"

var quest

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func startQuest(quest_name, id='001'):
	var file = File.new()
	file.open('%s/%s.json' % [quest_folder, id], file.READ) # ID dać do fora
	var json = file.get_as_text()
	quest = JSON.parse(json).result
	file.close()
	print(quest)
