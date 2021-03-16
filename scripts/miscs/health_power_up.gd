#script:health_power_up
extends Area2D
var hearts_scn = preload("res://Scenes/Miscs/heart_tex.tscn");
var temp_life = hearts_scn.instance();

func _process(_delta):
	position.y += Global.byte_array[8]/7
	
func _ready():
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	
func _on_health_power_up_area_entered(area):
	if area.is_in_group("player"):
		if Global.byte_array[26] < 9:
#			print("success")
				Global.byte_array[26] +=1;
				Global.hearts_loc.add_child(temp_life);
#				print("increamented")
		else:
			Global.byte_array[6] = 150;
		queue_free();
	
