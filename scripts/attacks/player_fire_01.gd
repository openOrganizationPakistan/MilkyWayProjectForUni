extends Area2D
#extends "res://scripts/Players/player_controls.gd"

var velocity = 0 setget set_velocity;

func _ready():
	scale = (Vector2(0.5,0.5) * Global.x_ratio).normalized();
	

func _process(delta):
	position -= Vector2(velocity ,Global.game_speed * 25 ) * delta * Global.y_ratio;
#	position.normalized();



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
	
