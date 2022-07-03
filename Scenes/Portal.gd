extends Area2D

export(PackedScene) var next_level


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene_to(next_level)