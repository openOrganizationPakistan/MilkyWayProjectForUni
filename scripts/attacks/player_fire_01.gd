#script: player_fire_01

extends "res://scripts/attacks/player_fire.gd"


func _process(delta):
	_fire(0,delta);
	



#func _on_VisibilityNotifier2D_viewport_exited(_viewport):
#	queue_free();
#	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
	pass # Replace with function body.
