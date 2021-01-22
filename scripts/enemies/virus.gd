extends Area2D

var health = PoolByteArray();
var x_direction;

func _ready():
	
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	
	health.append(80);
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
		health[0] -= Global.byte_array[5];
	if area.is_in_group("player"):
		health[0] -= 50;
		
	Global.enemy_c_health = (50 - health[0])
	
	if health[0] < 51:
		Global.current_score +=1;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$distroy.play("distroyed");
		$distroy.show();
	

func _on_distroy_animation_finished():
	queue_free();

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
