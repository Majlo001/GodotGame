"""
Janek Dialogue System
Author: MΔJLO
first commit: 07.03.20
last commit: 08.03.20
Version: 0.2
"""

extends Control

var dialogue_folder = 'res://dialogue/dialogues'

onready var frame : Node = $Frame
onready var label : Node = $Frame/RichTextLabel
onready var sprite_name : Node = $Frame/Label
onready var next_button : Node = $Frame/NextButton
onready var finish_button : Node = $Frame/FinishButton


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


func initial(file_id, block = '001'):
	id = file_id
	var file = File.new()
	file.open('%s/%s.json' % [dialogue_folder, id], file.READ)
	var json = file.get_as_text()
	dialogue = JSON.parse(json).result
	print("przeczytany")
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
			label.bbcode_text = block['text']
			check_names(block)
#			number_characters = phrase_raw.length()

			if block.has('next'):
				next_block = block['next']
			else:
				next_block = ''
			
				

#		'question':
#			label.bbcode_text = step['text']
#		'action':





func next():
	if next_block == '':
		frame.hide() 
	else:
		label.bbcode_text = ''
		update_dialogue(dialogue[next_block])

func not_question():
	is_question = false

func _ready():
	pass # Replace with function body.


func check_names(block):
	if not show_names:
		return
	if block.has('name'):
		sprite_name.text = block['name']
#		yield(get_tree(), 'idle_frame')
		sprite_name.set_process(true)
		sprite_name.show()
		sprite_name.hide()
	else:
		pass


func _on_NextButton_pressed():
	print("HOLA AMIGO")
	next()
