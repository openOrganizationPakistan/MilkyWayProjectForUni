#script:virus
extends Area2D

var x_direction;
onready var fire_scn = preload("res://Scenes/Attacks/enemy_fire.tscn");
var health = PoolByteArray();

func _ready():
	health.append(Global.byte_array[32]);
	scale = Global.universal_scale;
	x_direction = rand_range(-1,1)
	
func _process(_delta):
	position += Vector2(
		Global.byte_array[8]/5 * x_direction  ,
		int(Global.byte_array[8]/9)
	)
	if (position.x > Global._get_viewport_rect().x 
		or 
		position.x < 1
	):
		x_direction *=-1
	
func _on_virus_area_entered(area):
	
	if area.is_in_group("player_fire"):
		health[0] -= Global.byte_array[5];
		print("fire hit")
	if area.is_in_group("player"):
		health[0] -= 50;
		print("player hit")
	if health[0] < 51:
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
