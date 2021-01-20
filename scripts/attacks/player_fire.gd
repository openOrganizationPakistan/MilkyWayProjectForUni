#script: player_fire.gd
extends Area2D

var fire_type;

var velocity = 0 setget _set_velocity;
var laser_width = 0 setget _set_laser_width;

func _ready():
	scale = (Vector2(0.5,0.5) * Global.x_ratio).normalized();
	var _temp = connect("area_entered",self,"_on_player_fire_01_area_entered")
#	position.x = laser_width;


#func _process(delta):
#	
#	position -= Vector2(velocity ,Global.game_speed * 25 ) * delta * Global.y_ratio;
#	position.normalized();

func _input(event):
	match Global.fire_type:
		0:
			pass;
		1:
			if event is InputEventScreenTouch or event is InputEventScreenDrag:
				position = get_node("/root/Main_Scene/Player_01").position + Vector2(0,-30 * Global.y_ratio);
				
			
	

func _fire(index,delta):
	match index:
		0:
			position -= Vector2(velocity ,Global.game_speed * 25 ) * delta * Global.y_ratio;
		1:
			
			position.y -= (Global.game_speed * 25 ) * delta * Global.y_ratio;
			
		
		
	

func _set_laser_width(new_value):
	laser_width = new_value;
	pass;

func _on_player_fire_01_area_entered(area):
	if (area.is_in_group("player") 
	or
	area.is_in_group("player_fire")
	):
		pass
	else:
		match Global.fire_type:
			0:
#				Global.current_score += 1;
				queue_free();
			1:
				pass
		
	

func _set_velocity(new_value):
	velocity = int(new_value);
	
