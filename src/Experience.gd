extends Control

onready var label : Node = $Level
onready var progress : Node = $ProgressBar

var level = 4

var points = 3

var exp_points = 0

var exp_required = 100

signal point_change(value)

signal level_up(value)

func _ready():
	label.set_text(str(level))  # str convert to string

#func _physics_process(delta):
	progress.value = exp_points
	print(level)
	
	if progress.value >= exp_required:
		level_up()


func _on_Zombie_exp_gain(value):
	exp_points = exp_points + value
	progress.value = exp_points
	
	if progress.value >= exp_required:
		level_up()
	

func level_up():
	level = level + 1
	label.set_text(str(level))
	points = points + 1
	progress.value = 0
	exp_points = 0
	emit_signal("point_change", points)

