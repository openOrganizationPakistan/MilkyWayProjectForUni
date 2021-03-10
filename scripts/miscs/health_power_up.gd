#script:health_power_up
extends Area2D

func _process(_delta):
	position.y += Global.byte_array[8]/7
	
func _ready():
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	
func _on_health_power_up_area_entered(area):
	if area.is_in_group("player"):
		if Global.byte_array[6] >145:
#			print("success")
			if Global.byte_array[26] < (7):
				Global.byte_array[26] +=1;
#				print("increamented")
		else:
			Global.byte_array[6] = 150;
		queue_free();
	
