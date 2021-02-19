#script:BG_particles
extends Node2D

func _ready():
	$CPUParticles2D.position.x = 240*Global.x_ratio;
	$CPUParticles2D.emission_rect_extents.x = 240*Global.x_ratio;
	$CPUParticles2D.lifetime = 4 * Global.y_ratio;
