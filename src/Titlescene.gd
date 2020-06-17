extends Control

onready var NewGameButton = $HBoxContainer/VBoxContainer2/NewGame
onready var LoadGameButton = $HBoxContainer/VBoxContainer2/LoadGame
onready var OptionsButton = $HBoxContainer/VBoxContainer2/Options
onready var MultiplayerButton = $HBoxContainer/VBoxContainer2/Multiplayer
onready var Exit = $HBoxContainer/VBoxContainer2/Exit

onready var Dropdown = $Panel/OptionButton
onready var Panel = $Panel
onready var SaveName = $Panel/LineEdit
onready var StartButton = $Panel/StartButton


func _ready():
	add_dropdown_items()
	NewGameButton.grab_focus()
	StartButton.disabled = true

func _physics_process(_delta):
	if NewGameButton.is_hovered() == true:
		NewGameButton.grab_focus()
	if LoadGameButton.is_hovered() == true:
		LoadGameButton.grab_focus()
	if OptionsButton.is_hovered() == true:
		OptionsButton.grab_focus()
	if MultiplayerButton.is_hovered() == true:
		MultiplayerButton.grab_focus()
	if Exit.is_hovered() == true:
		Exit.grab_focus()


func add_dropdown_items():
	Dropdown.add_item("ŁATWY")
	Dropdown.add_item("ŚREDNI")
	Dropdown.add_item("TRUDNY")
	Dropdown.add_item("NIEMOŻLIWY")

func _on_NewGame_pressed():
	Panel.show()


func _on_LoadGame_pressed():
	pass # To be continued...


func _on_Options_pressed():
	pass # To be continued...


func _on_Multiplayer_pressed():
	pass # To be continued...


func _on_Exit_pressed():
	get_tree().quit()


func _on_LineEdit_text_changed(new_text):
	if SaveName.text != "":
		StartButton.disabled = false
	else:
		StartButton.disabled = true


func _on_StartButton_pressed():
	get_tree().change_scene("res://Levels/level3.tscn")


func _on_BackButton_pressed():
	Panel.hide()
