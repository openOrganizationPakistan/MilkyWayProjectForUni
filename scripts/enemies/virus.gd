extends Area2D

export var virus_speed_y = 1;
export var virus_speed_x = 2;

var x_dir;
var health = 10;

func _ready():
	scale = Vector2(Global.x_ratio,Global.x_ratio);
	x_dir = (rand_range(1,1))
	

func _process(_delta):
	
	position += Vector2(
		virus_speed_x * x_dir *2 ,
		virus_speed_y
	)
	
	if (position.x > Global._get_viewport_rect().x 
		or 
		position.x < 0
	):
		x_dir *=-1
	
	
	


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free();
	pass # Replace with function body.


func _on_virus_area_entered(area):
	
	if area.is_in_group("player_fire"):
		health -= Global.player_fire_damage;
		Global.enemy_c_health = health;
	
	if health <= 0 :
		$sprite.hide()
		$distroy.show()
		scale = scale/1.5;
		$distroy.play()
		$shape.set_deferred("disabled",true)
		Global.current_score +=1;


func _on_distroy_animation_finished():
	queue_free();
	pass # Replace with function body.
