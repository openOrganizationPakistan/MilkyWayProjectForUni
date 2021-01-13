extends Area2D

onready var laser_end_point = $laser_end_point_pos;

export var enemy_damage = int(10);

func _process(delta):
	
	scale += Vector2(0.01*Global.x_ratio,Global.game_speed * delta * 1 * Global.y_ratio).normalized();
	

func _on_laser_timer_timeout():
	queue_free();
	

func _on_rotate_laser_timeout():
	rotate(deg2rad(7.5))
	
