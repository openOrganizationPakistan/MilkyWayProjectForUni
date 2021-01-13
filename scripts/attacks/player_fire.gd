#script: player_fire.gd
extends Area2D

var fire_type;

var velocity = 0 setget set_velocity;

func _ready():
	scale = (Vector2(0.5,0.5) * Global.x_ratio).normalized();
	connect("area_entered",self,"_on_player_fire_01_area_entered")

#func _process(delta):
#	
#	position -= Vector2(velocity ,Global.game_speed * 25 ) * delta * Global.y_ratio;
#	position.normalized();

func _fire(index):
	match index:
		0:
			position -= Vector2(velocity ,Global.game_speed * 25 ) * get_physics_process_delta_time() * Global.y_ratio;
			
		1:
			_stay_in_touch();
			pass;
	

func _stay_in_touch():
	
	var event = InputEvent
	
	if ((event is InputEventScreenTouch) and event.is_pressed() ) or event is InputEventScreenDrag:
		
		position.x = lerp(position.x,event.position.x,Global.movement_speed) 
		
		
	


func _on_player_fire_01_area_entered(area):
	if (area.is_in_group("player") 
	or
	area.is_in_group("player_fire")
	):
		pass
	else:
		Global.current_score += 1;
		queue_free();
		
	

func set_velocity(new_value):
	velocity = int(new_value);
	

func _on_Timer_timeout():
	queue_free();
	
