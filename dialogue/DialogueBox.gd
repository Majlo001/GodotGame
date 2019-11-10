extends Control
class_name DialogueBox

signal dialogue_ended()

onready var dialogue_palyer : DialoguePlayer = get_node("Panel/DialoguePlayer")

onready var name_label : = get_node("Panel/Columns/Name") as Label
onready var text_label : = get_node("Panel/Columns/Text") as Label

onready var button_next : = get_node("Panel/Columns/ButtonNext") as Button
onready var button_finished : = get_node("Panel/Columns/ButtonFinished") as Button

onready var sprite : $Sprite as TextureRect

func start(dialogue : Dictionary) -> void:
	
	button_finished.hide()
	button_next.show()
	button_next.grab_focus()
	dialogue_player.start(dialogue)
	show()

func _on_ButtonNext_pressed() -> void:
	dialogue_player.next()
	update_content()

func _on_ButtonNext_pressed() -> void:
	button_next.hide()
	button_finished.show()
	button_finished.grab_focus()

func _on_ButtonFinished_pressed() -> void:
	emit_signal("dialogue_ended")
	hide()

func update_content() -> void:
	var dialogue_player_name = dialogue_player.title
	name_label.text = dialogue_player_name
	text_label.text = dialogue_player.title
	sprite.texture = DialogueDatabase.get_texture(dialogue_player_name, dialogue_player.expression)