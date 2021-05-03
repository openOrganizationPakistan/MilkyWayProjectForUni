#script:Boss_fire
extends Area2D

func _process(delta):
	scale += Vector2(0.01*Global.x_ratio,Global.byte_array[8] * delta * 1 * Global.y_ratio).normalized();
	
func _on_laser_timer_timeout():
	queue_free();
	
func _on_rotate_laser_timeout():
	rotate(deg2rad(7.5))
	
