#script:v_fire_power_up
extends Area2D

func _process(delta):
	position.y += Global.byte_array[8] * Global.movement_speed * delta;

func _ready():
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	

func _on_v_fire_power_up_area_entered(area):
	if area.is_in_group("player"):
		match Global.byte_array[13]:
			5:
				Global.byte_array[16] = 0;
			_:
				Global.byte_array[13] = (Global.byte_array[13] + 2) % 6;
				Global.byte_array[16] = 0;
		Global.byte_array[5] = 5;
		Global.byte_array[14] = 35;
		Global.bullets = 1000;
		queue_free();
		
	




