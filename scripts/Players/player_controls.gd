extends Area2D

var movement_speed = 0.2;

var ongoing_drag;

func _input(event):
	if ((event is InputEventScreenTouch) and event.is_pressed() ) or event is InputEventScreenDrag:
		
		position = Vector2(
			lerp(position.x,event.position.x,movement_speed)
			,lerp(position.y,event.position.y,movement_speed)
		) ;
		
		ongoing_drag = event.get_index();
		
	if ( (event is InputEventScreenDrag
			or event is InputEventScreenTouch)
			and
			 event.get_index() == ongoing_drag):
				
				if Global.game_speed < 50:
					Global.game_speed = 50;
		 
	
	print(Global.game_speed)
	
	
