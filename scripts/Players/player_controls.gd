extends Area2D

var movement_speed = 0.2;

func _input(event):
	if ((event is InputEventScreenTouch) and event.is_pressed() ) or event is InputEventScreenDrag:
		Global.game_speed = 50;
		position = Vector2(
			lerp(position.x,event.position.x,movement_speed)
			,lerp(position.y,event.position.y,movement_speed)
		) ;
	elif not(event.is_pressed() or event is InputEventScreenDrag):
		Global.game_speed = 1
	else: pass;
	
