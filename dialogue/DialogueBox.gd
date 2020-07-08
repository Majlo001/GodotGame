"""
Janek Dialogue System
Author: MΔJLO
first commit: 07.03.20
last commit: 27.04.20
Version: 1.2
"""

extends Control

var dialogue_folder = 'res://dialogue/dialogues'
onready var Janek = get_parent().get_parent().get_node('Janek')
onready var Jegomosc = get_parent().get_parent().get_node('Jegomosc')

#Camery
onready var MainCam = get_parent().get_parent().get_node('MainCam')
onready var JanekCam = Janek.get_node("Camera2D")

onready var frame : Node = $Frame
onready var label : Node = $Frame/RichTextLabel
onready var label2 : Node = $Frame/RichTextLabel2
onready var sprite_name : Node = $Frame/Label
onready var next_button : Node = $Frame/NextButton
onready var finish_button : Node = $Frame/FinishButton


onready var question_options : Node = $Frame/VBoxContainer
onready var option1 : Button = $Frame/VBoxContainer/Option1
onready var option2 : Button = $Frame/VBoxContainer/Option2
onready var option3 : Button = $Frame/VBoxContainer/Option3

onready var timer1 : Timer = $Timer1

var wait_time : float = 0.02 # TO BE CONTINUED...
var pause_time : float = 1.0
var pause_char : String = '|'
var reference_char : String = '['
var show_names : bool = true
var pause_char_on : bool = false


var id
var dialogue
var characters_number : = 0
var is_question : = false
var dialogues_dict = 'dialogues'
var current = ''
var next_block = ''

var chose_option1 = false


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
	match block['type']:
		'text':
			not_question()
			var text
			label2.bbcode_text = block['text']
			block['text'] = label2.text
			typewriter(block['text'])
			check_names(block)
			#characters_number = expression.length()
			print(characters_number)

			if block.has('next'):
				next_block = block['next']
			else:
				next_block = ''
			
		'question':
			check_names(block)
			typewriter(block['text'])
			show_question(block['options'])
			
#		'action':
#			not_question()
	if is_question == false:# Timer na grab focus, by nie łapał nexta przy rozpoczęciu dialogu
		var t = Timer.new() 
		t.set_wait_time(wait_time)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		next_button.grab_focus()


func update_dialogue_by_option(block1):
	next_block = block1
	next_button.show()
	finish_button.show()
	next()


func typewriter(string):
	var wt = wait_time
	for letter in string:
		if pause_char_on == false and letter == pause_char:
			wt = pause_time
			pause_char_on = true
		elif pause_char_on == true and letter == pause_char:
			wt = wait_time
			pause_char_on = false
		
		var act
		if string == '[':
			check_b(string)
		
		if letter == pause_char:
			pass
		else:
			timer1.start(wt)
			label.append_bbcode(letter)
			yield(timer1, "timeout")


func next():
	if next_block == '':
		change_camera(Janek.get_position())
		frame.hide()
		Janek.can_move = true
		JanekCam.current = true
	else:
		is_question(dialogue[next_block])
		print(is_question)
		if is_question == false:
				label.bbcode_text = ''
				update_dialogue(dialogue[next_block])
				print ("Next block")
		else:
			label.bbcode_text = ''
			update_dialogue(dialogue[next_block])


func not_question():
	is_question = false
	question_options.hide()


func is_question(block):
	if block['type'] == 'question':
		is_question = true
	else:
		is_question = false


func _ready():
	pass


func check_names(block):
	if not show_names:
		return
	if block.has('name'):
		MainCam.current = true
		sprite_name.text = block['name']
		sprite_name.set_process(true)
		sprite_name.show()
		
		
		#To Change
		if block['name'] == "Jegomość":
			change_camera(Jegomosc.get_position())
		if block['name'] == "Janek":
			change_camera(Janek.get_position())
		else:
			pass
		
	else:
		sprite_name.text = "nieznajomy"

func change_camera(target):
	MainCam.position = target


func show_question(options):
	next_button.hide()
	finish_button.hide()
	question_options.show()
	option1.text = options[0]
	option2.text = options[1]
	option3.text = options[2]
	option1.grab_focus()


func _on_NextButton_pressed():
	next()

func _on_FinishButton_pressed():
	frame.hide()
	Janek.can_move = true


func _on_Option1_pressed():
	#Dodać wait time
	#option2.hide()
	#option3.hide()
	update_dialogue_by_option(dialogue[next_block]['next'][0])
	


func _on_Option2_pressed():
	update_dialogue_by_option(dialogue[next_block]['next'][1])


func _on_Option3_pressed():
	update_dialogue_by_option(dialogue[next_block]['next'][2])

func check_b(string):
		pass
