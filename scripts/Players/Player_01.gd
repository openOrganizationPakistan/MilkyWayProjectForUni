extends "res://scripts/Players/player_controls.gd"

export var boss = int(15);
export var boss_fire = int(5);

var health = Global.player_health;

func _ready():
	scale = (Vector2(0.4,0.4) * Global.x_ratio);
	Global.player_c_health = health;
	var _temp = connect("area_entered",get_node("/root/Main_Scene"), "_player_colide" )

func _on_Player_01_area_entered(area):
	
	if area.is_in_group("boss"):
		health -= boss;
		Global.player_c_health -= boss;
		
	if area.is_in_group("boss_fire"):
#		health -= 15;
		health -= boss_fire;
		Global.player_c_health -= boss_fire;
	
	if health <= 0:
		if Global.current_score >= int(Global.high_score):
			Global._set_h_s(Global.current_score);
		
		Global.game_over = true;
		queue_free();
		var _temp=get_tree().change_scene("res://Scenes/UI.tscn");
		
	

		
#	if area.is_in_group("enemy"):
#		health -= Global.enemy_damage;
#		Global.player_c_health = health;
	

