#script:virus
extends Area2D

var health = PoolByteArray();
var x_direction;
var speed;

func _ready():
	health.append(Global.byte_array[30]);
	$effect.play("default",false);
	$effect2.play("default",true);
	$sprite.play("default",false);
	scale = Global.universal_scale;
	x_direction = rand_range(-1,1)
	speed = Vector2(
		Global.byte_array[8]/8 * Global.x_ratio ,
		int(Global.byte_array[8]/10) * Global.y_ratio
	)
	
func _process(_delta):
	position.x += (speed.x * x_direction);
	position.y += (speed.y);
	if (position.x > Global._get_viewport_rect().x 
		or 
		position.x < 0
	):
		x_direction *=-1
	
func _on_virus_area_entered(area):
	
	if area.is_in_group("player_fire"):
		health[0] -= Global.byte_array[5];
	if area.is_in_group("player"):
		health[0] -= 50;
	if health[0] < 51:
		Global.integer_array[1] +=1;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$effect.hide();
		$effect2.hide();
		$distroy.play("virus_dying");
		$distroy.show();
		match Global.byte_array[38]:
			1:
				$distroy_sound.play();
	
func _on_distroy_animation_finished():
	queue_free();
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
