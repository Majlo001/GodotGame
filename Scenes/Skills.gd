"""
Janek Skills System
Author: MΔJLO
first commit: 25.05.20
last commit: 25.05.20
Version: 0.3
"""

extends Control

onready var Janek = get_parent().get_parent().get_node('Janek')

onready var frame : Node = $Panel

onready var strength_count : Node = $Panel/HBoxContainer/VBoxContainer/Charisma/LabelCount
onready var dexterity_count : Node = $Panel/HBoxContainer/VBoxContainer/Dexterity/LabelCount
onready var durability_count : Node = $Panel/HBoxContainer/VBoxContainer/Durability/LabelCount
onready var inteligence_count : Node = $Panel/HBoxContainer/VBoxContainer/Inteligence/LabelCount
onready var charisma_count : Node = $Panel/HBoxContainer/VBoxContainer/Charisma/LabelCount

onready var strength_plus : Button = $Panel/HBoxContainer/VBoxContainer/Strength/ButtonPlus
onready var dexterity_plus : Button = $Panel/HBoxContainer/VBoxContainer/Dexterity/ButtonPlus
onready var durability_plus : Button = $Panel/HBoxContainer/VBoxContainer/Durability/ButtonPlus
onready var inteligence_plus : Button = $Panel/HBoxContainer/VBoxContainer/Inteligence/ButtonPlus
onready var charisma_plus : Button = $Panel/HBoxContainer/VBoxContainer/Charisma/ButtonPlus

onready var strength_minus : Button = $Panel/HBoxContainer/VBoxContainer/Strength/ButtonMinus
onready var dexterity_minus : Button = $Panel/HBoxContainer/VBoxContainer/Dexterity/ButtonMinus
onready var durability_minus : Button = $Panel/HBoxContainer/VBoxContainer/Durability/ButtonMinus
onready var inteligence_minus : Button = $Panel/HBoxContainer/VBoxContainer/Inteligence/ButtonMinus
onready var charisma_minus : Button = $Panel/HBoxContainer/VBoxContainer/Charisma/ButtonMinus

onready var points_count : Node = $Panel/HBoxContainer/VBoxContainer/Points/LabelCount

var visible_panel = false

var points = 3

func _ready():
	strength_count.text = str(Janek.strength)
	dexterity_count.text = str(Janek.dexterity)
	durability_count.text = str(Janek.durability)
	inteligence_count.text = str(Janek.inteligence)
	charisma_count.text = str(Janek.charisma)
	points_count.text = str(points)
	
	strength_minus.disabled = true
	dexterity_minus.disabled = true
	durability_minus.disabled = true
	inteligence_minus.disabled = true
	charisma_minus.disabled = true

func _input(event):
	if event.is_action_pressed("ui_skills"):
		if visible_panel == false:
			Janek.can_move = false
			visible_panel = true
			frame.show()
		else:
			Janek.can_move = true
			visible_panel = false
			frame.hide()
