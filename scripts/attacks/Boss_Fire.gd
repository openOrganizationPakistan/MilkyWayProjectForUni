extends Area2D

onready var laser_end_point = $laser_end_point_pos;

export var enemy_damage = int(10);

func _ready():
	Global.enemy_damage = enemy_damage;

func _process(delta):
	
	scale.y += (Global.game_speed * delta * 1 * Global.y_ratio);
	
#	if rotation_degrees >=15:
#		rotation_degrees = 15;
	
	

func _on_laser_timer_timeout():
	queue_free();
	

func _on_rotate_laser_timeout():
	rotate(deg2rad(15))
	
