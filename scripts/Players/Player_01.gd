extends "res://scripts/Players/player_controls.gd"

export var boss = int(15);
export var boss_fire = int(5);

var health = Global.player_health;

func _ready():
	scale = (Vector2(0.4,0.4) * Global.x_ratio);
	

func _on_Player_01_area_entered(area):
	
	if health <= 0:
		if Global.current_score >= int(Global.high_score):
			Global.set_h_s(Global.current_score);
		
		Global.game_over = true;
		var _temp=get_tree().change_scene("res://Scenes/UI.tscn");
		
	
	if area.is_in_group("boss"):
		health -= int(15);
		
	elif area.is_in_group("boss_fire"):
#		health -= 15;
		health -= int(5);
		
	elif area.is_in_group("enemy"):
		health -= Global.enemy_damage;
	
	

