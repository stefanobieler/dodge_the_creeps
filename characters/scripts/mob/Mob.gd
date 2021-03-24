extends RigidBody2D

class_name Mob

export var min_speed = 150
export var max_speed = 250



func _ready():
	var mob_types = $View.frames.get_animation_names()
	$View.animation = mob_types[randi() % mob_types.size()]
	


func _on_VisibilityNotifier_screen_exited():
	queue_free()
