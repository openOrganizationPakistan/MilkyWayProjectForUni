extends Node2D

func _ready():
	$CPUParticles2D.position.x = 240*Global.x_ratio;
	$CPUParticles2D.emission_rect_extents.x = 240*Global.x_ratio;
	pass # Replace with function body.
