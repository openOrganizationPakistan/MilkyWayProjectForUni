extends Area2D
#extends "res://scripts/Players/player_controls.gd"

func _process(delta):
	position.y += Global.game_speed * 25 * delta;
