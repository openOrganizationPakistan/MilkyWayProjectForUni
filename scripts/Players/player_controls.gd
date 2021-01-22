extends Area2D

var ongoing_drag;

func _input(event):
	if ((event is InputEventScreenTouch) and event.is_pressed() ) or event is InputEventScreenDrag:
		if Global.byte_array[6] > 50: # health ranges from 50 to 150 instead of 0 to 100
			position = Vector2(
				lerp(position.x,event.position.x,Global.movement_speed)
				,lerp(position.y,event.position.y,Global.movement_speed)
			) ;
		
		ongoing_drag = event.get_index();
		
	
