#script: player_fire.gd
extends Area2D

var fire_type;
var velocity = 0 ;
var laser_width = 0 ;

func _ready():
	scale = Global.universal_scale;
	var _temp = connect("area_entered",self,"_on_player_fire_01_area_entered")
	
func _process(delta):
	match Global.byte_array[2]:
		0:
			position += Vector2(velocity * Global.byte_array[23] ,Global.byte_array[8] * 25 ) * delta ;
		1:
			
			position.y = (Global.byte_array[8] * 25 ) * delta ;
			
		
	
func _on_player_fire_01_area_entered(area):
	if (area.is_in_group("virus") 
	or
	area.is_in_group("todda")
	or 
	area.is_in_group("fighter")
	or
	area.is_in_group("power_up")
	):
		return;
	else:
		queue_free();
		
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
