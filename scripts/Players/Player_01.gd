extends "res://scripts/Players/player_controls.gd"

var health = Global.player_health;

func _ready():
	scale = (Vector2(0.4,0.4) * Global.x_ratio);
	

func _on_Player_01_area_entered(area):
	if health <= 0:
		if Global.current_score >= int(Global.high_score):
			Global.set_h_s(Global.current_score);
		
		Global.game_over = true;
		var _temp=get_tree().change_scene("res://Scenes/UI.tscn");
		
	
	if area.is_in_group("enemy"):
		health -= Global.enemy_damage;
		
		
	
