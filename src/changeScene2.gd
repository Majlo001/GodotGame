extends Area2D

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Janek":
			get_tree().change_scene("Levels/level3.tscn")