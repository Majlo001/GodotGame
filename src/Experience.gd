extends Control

onready var label : Node = $Level
onready var progress : Node = $ProgressBar

var level = 4

var points = 3

func _ready():
	label.set_text(str(level))  # str convert to string
