#script:virus
extends Area2D

var x_direction;

func _ready():
	Global.byte_array[30] = 80;
	$effect.play("default",false);
	$effect2.play("default",true);
	$sprite.play("default",false);
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
		Global.byte_array[30] -= Global.byte_array[5];
	if area.is_in_group("player"):
		Global.byte_array[30] -= 50;
	Global.enemy_c_health = (50 - Global.byte_array[30])
	if Global.byte_array[30] < 51:
		Global.current_score +=1;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$effect.hide();
		$effect2.hide();
		$distroy.play("destroyed-ulq");
		$distroy.show();
	
func _on_distroy_animation_finished():
	queue_free();
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
