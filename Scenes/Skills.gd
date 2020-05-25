"""
Janek Skills System
Author: MΔJLO
first commit: 25.05.20
last commit: 25.05.20
Version: 0.5
"""

extends Control

onready var Janek = get_parent().get_parent().get_node('Janek')
const experience = preload('res://src/Experience.gd')
onready var Experience = experience.new()

onready var frame : Node = $Panel

onready var strength_count : Node = $Panel/HBoxContainer/VBoxContainer/Strength/LabelCount
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

var points
var strength
var durability
var dexterity
var inteligence
var charisma

func _ready():
	first()

	strength_count.text = strength
	dexterity_count.text = dexterity
	durability_count.text = durability
	inteligence_count.text = inteligence
	charisma_count.text = charisma
	
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



func _on_ButtonPlus_pressed(extra_arg):
	print(extra_arg)
	
	if extra_arg == "str" and points > 0:
		strength_minus.disabled = false
		points-=1
		strength = int(strength)+1 
		refresh()
		
	if extra_arg == "dex" and points > 0:
		dexterity_minus.disabled = false
		points-=1
		dexterity = int(dexterity)+1 
		refresh()
	
	if extra_arg == "dur" and points > 0:
		durability_minus.disabled = false
		points-=1
		durability = int(durability)+1 
		refresh()
	
	if extra_arg == "int" and points > 0:
		inteligence_minus.disabled = false
		points-=1
		inteligence = int(inteligence)+1 
		refresh()
	
	if extra_arg == "cha" and points > 0:
		charisma_minus.disabled = false
		points-=1
		charisma = int(charisma)+1 
		refresh()
	
	zero()

func refresh():
	strength_count.text = str(strength)
	dexterity_count.text = str(dexterity)
	durability_count.text = str(durability)
	inteligence_count.text = str(inteligence)
	charisma_count.text = str(charisma)
	points_count.text = str(points)

func first():
	strength = str(Janek.strength)
	dexterity = str(Janek.dexterity)
	durability = str(Janek.durability)
	inteligence = str(Janek.inteligence)
	charisma = str(Janek.charisma)
	points = Experience.points
	points_count.text = str(points)
	zero()

func disabledMinus():
	strength_minus.disabled = true
	dexterity_minus.disabled = true
	durability_minus.disabled = true
	inteligence_minus.disabled = true
	charisma_minus.disabled = true

func disabledPlus():
	strength_plus.disabled = true
	dexterity_plus.disabled = true
	durability_plus.disabled = true
	inteligence_plus.disabled = true
	charisma_plus.disabled = true

func enabledPlus():
	if points > 0:
		strength_plus.disabled = false
		dexterity_plus.disabled = false
		durability_plus.disabled = false
		inteligence_plus.disabled = false
		charisma_plus.disabled = false
	
func zero():
	if points == 0:
		disabledPlus()

func _on_ButtonReset_pressed():
	first()
	refresh()
	enabledPlus()
	disabledMinus()


func _on_ButtonConfirm_pressed():
	Janek.strength = strength
	Janek.dexterity = dexterity
	Janek.durability = durability
	Janek.inteligence = inteligence
	Janek.charisma = charisma
	Experience.points = points
	disabledMinus()
	zero()


func _on_ButtonMinus_pressed(extra_arg):
	print(extra_arg)
	
	if extra_arg == "str":
		strength_minus.disabled = false
		points+=1
		strength = int(strength)-1 
		refresh()
		if Janek.strength == strength:
			strength_minus.disabled = true
	
	if extra_arg == "dex":
		dexterity_minus.disabled = false
		points+=1
		dexterity = int(dexterity)-1 
		refresh()
		if Janek.dexterity == dexterity:
			dexterity_minus.disabled = true
	
	if extra_arg == "dur":
		durability_minus.disabled = false
		points+=1
		durability = int(durability)-1 
		refresh()
		if Janek.durability == durability:
			durability_minus.disabled = true
	
	if extra_arg == "int":
		inteligence_minus.disabled = false
		points+=1
		inteligence = int(inteligence)-1 
		refresh()
		if Janek.inteligence == inteligence:
			inteligence_minus.disabled = true
	
	if extra_arg == "cha":
		charisma_minus.disabled = false
		points+=1
		charisma = int(charisma)-1 
		refresh()
		if Janek.charisma == charisma:
			charisma_minus.disabled = true
	
	enabledPlus()
