extends Area2D
#extends "res://scripts/Players/player_controls.gd"

func _ready():
	scale = Vector2(0.5,0.5);
	Global.player_fire_damage = 5;

func _process(delta):
	position.y -= Global.game_speed * 25 * delta;


func _on_Timer_timeout():
	queue_free();
	pass # Replace with function body.
