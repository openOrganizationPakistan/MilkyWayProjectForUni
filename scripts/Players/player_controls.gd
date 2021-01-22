extends Area2D

var ongoing_drag;

func _input(event):
	if ((event is InputEventScreenTouch) and event.is_pressed() ) or event is InputEventScreenDrag:
		
		position = Vector2(
			lerp(position.x,event.position.x,Global.movement_speed)
			,lerp(position.y,event.position.y,Global.movement_speed)
		) ;
		
		ongoing_drag = event.get_index();
		
	
