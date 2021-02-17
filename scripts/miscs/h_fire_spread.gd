extends Area2D

func _process(_delta):
	position.y += Global.byte_array[8]/7

func _ready():
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	

func _on_h_fire_spread_area_entered(area):
	if area.is_in_group("player"):
		match Global.byte_array[13]:
			5:
				Global.byte_array[16] = 1;
			_:
				Global.byte_array[13] = (Global.byte_array[13] + 2) % 6;
				Global.byte_array[16] = 1;
		Global.byte_array[5] = 5;
		Global.byte_array[14]=25;
		Global.bullets += 1000;
		queue_free();
		
	
