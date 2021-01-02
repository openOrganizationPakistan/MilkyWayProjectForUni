extends Area2D

onready var laser_end_point = $laser_end_point_pos;

func _process(delta):
	
	scale.y += Global.game_speed * delta * 1;
	

func _on_laser_timer_timeout():
	queue_free();
	


func _on_rotate_laser_timeout():
	rotate(deg2rad(15))
