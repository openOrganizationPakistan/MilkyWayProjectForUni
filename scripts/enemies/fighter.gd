#script:virus
extends Area2D

var x_direction;
onready var fire_scn = preload("res://Scenes/Attacks/enemy_fire.tscn");

func _ready():
	Global.byte_array[32] = 120;
	scale = Global.universal_scale;
	x_direction = rand_range(-1,1)
	
func _process(_delta):
	position += Vector2(
		Global.byte_array[8]/5 * x_direction  ,
		int(Global.byte_array[8]/9)
	)
	if (position.x > Global._get_viewport_rect().x 
		or 
		position.x < 0
	):
		x_direction *=-1
	
func _on_virus_area_entered(area):
	
	if area.is_in_group("player_fire"):
		Global.byte_array[32] -= Global.byte_array[5];
	if area.is_in_group("player"):
		Global.byte_array[32] -= 50;
	
	if Global.byte_array[32] < 51:
		Global.current_score +=1;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$distroy.play("destroyed-ulq");
		$distroy.show();
	
func _on_distroy_animation_finished():
	queue_free();
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free();


func _on_Timer_timeout():
	var fire = fire_scn.instance();
	fire.position = Vector2(position.x,position.y + (50 * Global.y_ratio));
	fire.z_index = -3;
	get_tree().get_root().add_child(fire,true);
	pass # Replace with function body.
