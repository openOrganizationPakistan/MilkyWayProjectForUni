#script:health_power_up
extends Area2D
export (PackedScene) onready var hearts_scn = preload("res://Scenes/Miscs/heart_tex.tscn");
onready var hearts_loc = get_tree().get_root().find_node("heartsContainer",true,false);

func _process(delta):
	position.y += Global.byte_array[8] * Global.integer_array[0] * delta;
	
func _ready():
	print_stray_nodes();
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	
func _on_health_power_up_area_entered(area):
	if area.is_in_group("player"):
		if Global.byte_array[26] < 10:
			Global.byte_array[26] +=1;
			hearts_loc.add_child(hearts_scn.instance());
		else:
			Global.byte_array[6] = 150;
		queue_free();
	
