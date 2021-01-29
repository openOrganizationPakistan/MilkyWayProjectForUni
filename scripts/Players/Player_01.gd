extends "res://scripts/Players/player_controls.gd"

func _ready():
	scale = (Vector2(0.4,0.4) * Global.x_ratio);
	Global.byte_array[6] = Global.byte_array[4]; # player current health's global status
	

func _on_Player_01_area_entered(area):
	
	if area.is_in_group("boss"):
		Global.byte_array[6] -= Global.byte_array[3];
		
	if area.is_in_group("boss_fire"):
		Global.byte_array[6] -= Global.byte_array[10];
		
	if area.is_in_group("virus"):
		Global.byte_array[6] -= Global.byte_array[11]; 
	
	if Global.byte_array[6] <= 50 :
		if ( Global.current_score  >= int(Global.high_score) ):
			Global._set_h_s( (Global.current_score ) );
		
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$distroy.show();
		$distroy.play("destroyed-ulq");
		
	

func _on_distroy_animation_finished():
	Global.byte_array[0] = 1;
	














