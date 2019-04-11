extends Control

func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()

func _physics_process(delta):
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton2.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton2.grab_focus()
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible