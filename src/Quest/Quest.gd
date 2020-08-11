extends Control


var quest_folder = 'res://src/Quest/quests'

onready var quest_label : Node = $Frame/QuestLabel

#Colors
const Colors = preload("res://src/core/colors.gd")
var colors = Colors.new()

#Changeable
var questWidth = 11 #Number of title quests.
var questHeight = 10 #Max Number of quest in title quests.
var killQuestWidth = 5 #Number of kill quests.
var collectQuestWidth = 6 #Number of collect quests.
var deliverQuestWidth = 7 #Number of deliver quests.

var quest
var questArray = []
var killQuestArray = []
var collectQuestArray = []
var deliverQuestArray = []
var arrayNum
var title : String
var text : String
var killCount : String
var killAmount : String


func createQuestArray(): #Made only on starting/creating game.
	questArray.resize(questWidth)
	for x in range(0, questWidth, 1):
		questArray[x]=[]
		questArray[x].resize(questHeight)
	
	for x in range(0, questWidth, 1): #Make every questArray on false.
		for y in range(0, questHeight, 1):
			questArray[x][y] = false
	
	createTypeQuestArray()

func createTypeQuestArray(): #Made only on starting/creating game.
	killQuestArray.resize(killQuestWidth) #Make every deliverQuestArray to 0.
	for x in range(0, killQuestWidth, 1):
		killQuestArray[x] = 0
		
	collectQuestArray.resize(collectQuestWidth) #Make every deliverQuestArray to 0.
	for x in range(0, collectQuestWidth, 1):
		collectQuestArray[x] = 0
		
	deliverQuestArray.resize(deliverQuestWidth) #Make every deliverQuestArray to 0.
	for x in range(0, deliverQuestWidth, 1):
		deliverQuestArray[x] = 0

func _ready():
	startQuest("quest1")#Test
	createQuestArray()#Test
	print(questArray)#Test
	pass 

func startQuest(quest_name, block = '001'):
	var file = File.new()
	file.open('%s/%s.json' % [quest_folder, quest_name], file.READ)
	var json = file.get_as_text()
	quest = JSON.parse(json).result
	file.close()
	
	checkTitle(quest)
	readQuest(quest[block])
	print(quest[block])
	checkNext(quest, block)


func readQuest(block):
	match block['type']:
		'find':
			print(quest_label)
			print(block['text'])
			text = '[color=' + colors.lapis_blue + ']' + block['text']  + '[/color]' + '\n'
			quest_label.append_bbcode(text)
		
		'kill':
			print("kill")
			killCounter(block["killArray"], block['creature'], block['count'])
			killAmount = String(block['count']) #Number of creatures player have to kill
			print("=====")
			print(block["killArray"])
			print(killQuestArray[0])
			#killCount = String(killQuestArray[block["killArray"]]) #Number of creatures player killed
			text = '[color=' + colors.ferrari_red + ']' + block['text']  + ' | ' + killCount + '/' + killAmount + '[/color]' + '\n'
			quest_label.append_bbcode(text)
		
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

func killCounter(killArray, creature, count):
	pass

func checkTitle(block):
	title = block["title"]
	arrayNum = block["arrayNum"]
	print(title)
	print(arrayNum)

func checkNext(block, num):
	var blc = block[num]
	if blc.has('next'):
		num = blc['next']
		readQuest(block[num]) 
