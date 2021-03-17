#script:player_controls
extends Area2D

var pos = Vector2(240*Global.x_ratio,320*Global.y_ratio);

func _input(event):
	if ((event is InputEventScreenTouch) and event.is_pressed() ) or event is InputEventScreenDrag:
		
		if Global.byte_array[6] > 50 and event.get_index() == 0 : # health ranges from 50 to 150 instead of 0 to 100
			if event.position.y>250*Global.y_ratio:
				if Global.byte_array[25] == 1:
					pos = event.position;
			
#			position = Vector2(
#				lerp(position.x,event.position.x,Global.movement_speed)
#				,lerp(position.y,event.position.y,Global.movement_speed)
#			) ;
	
func _process(delta):
	if Global.byte_array[27] == 5:
		Global.byte_array[27] = 6;
		pos = Vector2(Global._get_viewport_rect().x/2,Global._get_viewport_rect().y/1.2);
	position = Vector2(
		lerp(position.x,pos.x,Global.movement_speed * delta)
		, lerp(position.y,pos.y,Global.movement_speed * delta )
	);
	
