#script for todda enemy
extends Area2D

func _ready():
	Global.byte_array[31] = 80;
	scale = Global.universal_scale;
	
func _process(_delta):
	position.y += Global.byte_array[20] ;
	
func _on_todda_area_entered(area):
	if (
		area.is_in_group("player_fire") 
		or area.is_in_group("player")
	):
		Global.byte_array[31] -= 5
	if ( Global.byte_array[31] < 51) :
		Global.current_score +=1;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$distroy.play("destroyed-ulq");
		$distroy.show();
	
func _on_distroy_animation_finished():
	queue_free();

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
