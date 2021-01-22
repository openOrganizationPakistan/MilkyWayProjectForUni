#script: player_fire_01

extends "res://scripts/attacks/player_fire.gd"


func _process(delta):
	_fire(delta);
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
