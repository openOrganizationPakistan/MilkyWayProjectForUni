extends Area2D
#extends "res://scripts/Players/player_controls.gd"

func _ready():
	scale = Vector2(0.5,0.5) * Global.x_ratio;
	

func _process(delta):
	position.y -= Global.game_speed * 25 * delta * Global.y_ratio;


func _on_Timer_timeout():
	queue_free();


func _on_player_fire_01_area_entered(area):
	if !area.is_in_group("player"):
		Global.current_score += 1;
		queue_free();
