extends Node2D

onready var boss = $Boss;
onready var level_change = $level_change;

func _return_level(index):
	return get_child(index).duplicate();
	

func _on_Boss_area_entered(_area):
	
	if boss.health<=0+Global.player_fire_damage:
		level_change.text = "congrats\n\nYou won!"
		level_change.rect_position = Vector2(
			(240*Global.x_ratio)-(level_change.rect_size.x/2)
			,(320*Global.y_ratio) -(level_change.rect_size.y)/2
			);
		level_change.show();
		
	
