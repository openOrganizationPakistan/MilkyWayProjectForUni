#script for todda enemy
extends Area2D
var health = PoolByteArray();

func _ready():
	health.append(Global.byte_array[31]);
	scale = Global.universal_scale;
	
func _process(_delta):
	position.y += Global.byte_array[20] ;
	
func _on_todda_area_entered(area):
	if (
		area.is_in_group("player_fire") 
		or area.is_in_group("player")
	):
		health[0] -= Global.byte_array[5];
	if ( health[0] < 51) :
		Global.integer_array[1] +=1;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$engine_fire.hide();
		$distroy.play("destroyed-ulq");
		$distroy.show();
		match Global.byte_array[38]:
			1:
				$distroy_sound.play();
	
func _on_distroy_animation_finished():
	queue_free();

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
