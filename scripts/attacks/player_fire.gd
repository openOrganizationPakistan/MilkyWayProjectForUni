#script: player_fire.gd
extends Area2D

var fire_type;

var velocity = 0 setget _set_velocity;
var laser_width = 0 setget _set_laser_width;

func _ready():
	if Global.bullets > 0:
		Global.bullets -=1;
	scale = Global.universal_scale;
	var _temp = connect("area_entered",self,"_on_player_fire_01_area_entered")
	

func _input(event):
	match Global.byte_array[2]:
		0:
			pass;
		1:
			if event is InputEventScreenTouch or event is InputEventScreenDrag:
				position = get_node("/root/Main_Scene/Player_01").position + Vector2(0,-30 * Global.y_ratio);
				
			
	

func _fire(delta):
	match Global.byte_array[2]:
		0:
			position -= Vector2(velocity * Global.byte_array[23] ,Global.byte_array[8] * 25 ) * delta ;
		1:
			
			position.y -= (Global.byte_array[8] * 25 ) * delta ;
			
		
		
	

func _set_laser_width(new_value):
	laser_width = new_value;
	

func _on_player_fire_01_area_entered(area):
	if (area.is_in_group("player") 
	or
	area.is_in_group("player_fire")
	or 
	area.is_in_group("power_up")
	):
		pass
	else:
		match Global.byte_array[2]:
			0:
#				Global.current_score += 1;
				queue_free();
			1:
				pass
		
	

func _set_velocity(new_value):
	velocity = (new_value);
	
