extends Area2D

var health = PoolByteArray([80]);

func _ready():
	
	scale = Global.universal_scale;
	

func _process(_delta):
	position.y += Global.byte_array[20];
	


func _on_todda_area_entered(area):
	
	if (
		area.is_in_group("player_fire") 
		or area.is_in_group("player")
	):
		
		health[0] -= 5
		
	if ( health[0] < 51) :
		
		Global.current_score +=1;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$distroy.play("destroyed-ulq");
		$distroy.show();
		
	

func _on_distroy_animation_finished():
	queue_free();

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
