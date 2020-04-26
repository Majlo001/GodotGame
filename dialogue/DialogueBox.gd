"""
Janek Dialogue System
Author: MΔJLO
first commit: 07.03.20
last commit: 08.04.20
Version: 0.5
"""

extends Control

var dialogue_folder = 'res://dialogue/dialogues'
onready var Janek = get_parent().get_parent().get_node('Janek')

#Camery
onready var JegomoscCam = get_parent().get_parent().get_node('Jegomosc-cam')
onready var JanekCam = Janek.get_node("Camera2D")

onready var frame : Node = $Frame
onready var label : Node = $Frame/RichTextLabel
onready var sprite_name : Node = $Frame/Label
onready var next_button : Node = $Frame/NextButton
onready var finish_button : Node = $Frame/FinishButton


onready var question_options : Node = $Frame/VBoxContainer
onready var option1 : Button = $Frame/VBoxContainer/Option1
onready var option2 : Button = $Frame/VBoxContainer/Option2
onready var option3 : Button = $Frame/VBoxContainer/Option3

onready var timer1 : Timer = $Timer1

var wait_time : float = 0.02 # TO BE CONTINUED...
var pause_time : float = 2.0
var pause_char : String = '|'
var newline_char : String = '@'
var show_names : bool = true


var id
var dialogue
var characters_number : = 0
var is_question : = false
var dialogues_dict = 'dialogues'
var current = ''
var next_block = ''
var expression = ''


func initial(file_id, block = '001'):
	Janek.can_move = false
	id = file_id
	var file = File.new()
	file.open('%s/%s.json' % [dialogue_folder, id], file.READ)
	var json = file.get_as_text()
	dialogue = JSON.parse(json).result
	file.close()
	first(block)


func first(block):
	frame.show()
	if block == '001':
#		pass
#		if dialogue.has('repeat'):
#			if progress.get(dialogues_dict).has(id): 
#				update_dialogue(dialogue['repeat']) 
#			else:
#				progress.get(dialogues_dict)[id] = true 
		update_dialogue(dialogue['001']) 
#		else:
#		update_dialogue(dialogue['002'])
	else: 
		update_dialogue(dialogue[block])



func clean():
	pass


func update_dialogue(block):
	current = block
	characters_number = 0
	
	match block['type']:
		'text':
			not_question()
			#label.bbcode_text = block['text']
			typewriter(block['text'])
			check_names(block)
			characters_number = expression.length()
			print(characters_number)

			if block.has('next'):
				next_block = block['next']
			else:
				next_block = ''
			
		'question':
			var que
			label.bbcode_text = block['text']
			que = question(block['text'], block['options'], block['next'])
			check_names(block)
			#next_block = block['next'][que]
			
			
#		'action':
#			not_question()
	var t = Timer.new() # Timer na grab focus, by nie łapał nexta przy rozpoczęciu dialogu
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	next_button.grab_focus()


func typewriter(string):
	for letter in string:
		timer1.start(wait_time)
		label.append_bbcode(letter)
		yield(timer1, "timeout")


func next():
	if next_block == '':
		frame.hide()
		Janek.can_move = true
	else:
		label.bbcode_text = ''
		update_dialogue(dialogue[next_block])

func not_question():
	is_question = false

func _ready():
	pass


func check_names(block):
	if not show_names:
		return
	if block.has('name'):
		sprite_name.text = block['name']
		sprite_name.set_process(true)
		sprite_name.show()
		
		
		#To Change
		if block['name'] == "Jegomość":
			print("ss")
			JegomoscCam.current = true
		else:
			JanekCam.current = true
		
	else:
		pass


func question(text, options, next):
	question_options.show()
	option1.text = options[0]
	option2.text = options[1]
	option3.text = options[2]
	
	if option1.is_hovered() == true:
		option1.grab_focus()
		
	if option2.is_hovered() == true:
		option2.grab_focus()
		
	if option3.is_hovered() == true:
		option3.grab_focus()
		
	

func _on_NextButton_pressed():
	next()

func _on_FinishButton_pressed():
	frame.hide()
	Janek.can_move = true
