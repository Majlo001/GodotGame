extends Control


onready var NewGameButton = $HBoxContainer/VBoxContainer2/NewGame
onready var LoadGameButton = $HBoxContainer/VBoxContainer2/LoadGame
onready var OptionsButton = $HBoxContainer/VBoxContainer2/Options
onready var MultiplayerButton = $HBoxContainer/VBoxContainer2/Multiplayer
onready var Exit = $HBoxContainer/VBoxContainer2/Exit

func _ready():
	NewGameButton.grab_focus()

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


func _on_NewGame_pressed():
	pass # Replace with function body.


func _on_LoadGame_pressed():
	pass # Replace with function body.


func _on_Options_pressed():
	pass # Replace with function body.


func _on_Multiplayer_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	pass # Replace with function body.
