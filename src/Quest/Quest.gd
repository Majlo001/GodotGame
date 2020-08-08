extends Node2D


var quest_folder = 'res://src/Quest/quests'

onready var quest_label : Node = $GGLabel

var quest


func _ready():
	pass 

func startQuest(quest_name, block = '001'):
	var file = File.new()
	file.open('%s/%s.json' % [quest_folder, quest_name], file.READ) # 
	var json = file.get_as_text()
	quest = JSON.parse(json).result
	file.close()
	readQuest(quest[block])


func readQuest(block):
	match block['type']:
		'find':
			print(quest_label)
			print(block['text'])
			get_node("GGLabel").bbcode_text = block['text']
			#block['text'] = quest_label.text
