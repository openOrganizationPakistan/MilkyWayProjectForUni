#script:health_power_up
extends Area2D
var hearts_scn = preload("res://Scenes/Miscs/heart_tex.tscn");
var temp_life = hearts_scn.instance(); 
onready var hearts_loc = get_tree().get_root().find_node("heartsContainer",true,false);

func _process(delta):
	position.y += Global.byte_array[8] * Global.movement_speed * delta;
	
func _ready():
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	
func _on_health_power_up_area_entered(area):
	if area.is_in_group("player"):
		if Global.byte_array[26] < 10:
#			print("success")
			Global.byte_array[26] +=1;
			hearts_loc.add_child(temp_life);
#			print("increamented")
		else:
			Global.byte_array[6] = 150;
		queue_free();
	
