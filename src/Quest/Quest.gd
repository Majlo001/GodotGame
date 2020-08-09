extends Control


var quest_folder = 'res://src/Quest/quests'

onready var quest_label : Node = $Frame/QuestLabel
#$Frame/QuestLabel
#get_parent().get_node("Quest/Frame/QuestLabel")


var quest


func _ready():
	startQuest("quest1")
	pass 

func startQuest(quest_name, block = '001'):
	var file = File.new()
	file.open('%s/%s.json' % [quest_folder, quest_name], file.READ) # 
	var json = file.get_as_text()
	quest = JSON.parse(json).result
	file.close()
	readQuest(quest[block])
	print(quest[block])
	checkNext(quest, block)


func readQuest(block):
	match block['type']:
		'find':
			print(quest_label)
			print(block['text'])
			quest_label.append_bbcode(block['text'] + '\n')
		
		'kill':
			print("kill")
			print(block['text'])
			quest_label.append_bbcode(block['text'] + '\n')
		
		'collect':
			print("collect")
			print(block['text'])
			quest_label.append_bbcode(block['text'] + '\n')
		
		'craft':
			print("craft")
			print(block['text'])
			quest_label.append_bbcode(block['text'] + '\n')
		
		'fetch':
			print("fetch")
			print(block['text'])
			quest_label.append_bbcode(block['text'] + '\n')
		
		'defend':
			print("defend")
			print(block['text'])
			quest_label.append_bbcode(block['text'] + '\n')
		
		'deliver':
			print("deliver")
			print(block['text'])
			quest_label.append_bbcode(block['text'] + '\n')


func checkNext(block, num):
	var blc = block[num]
	if blc.has('next'):
		num = blc['next']
		readQuest(block[num]) 
