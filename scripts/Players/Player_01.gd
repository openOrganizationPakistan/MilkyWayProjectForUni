extends "res://scripts/Players/player_controls.gd"

export var boss = int(15);
export var boss_fire = int(5);
export var virus = int(50);

var health = Global.player_health;

func _ready():
	scale = (Vector2(0.4,0.4) * Global.x_ratio);
	Global.player_c_health = health;
	

func _on_Player_01_area_entered(area):
	
	if area.is_in_group("boss"):
		health -= boss;
		Global.player_c_health = health;
		
	if area.is_in_group("boss_fire"):
#		health -= 15;
		health -= boss_fire;
		Global.player_c_health = health;
		
	if area.is_in_group("virus"):
		health -= virus
		Global.player_c_health = health;
	
	if health <= 0:
		$sprite.hide();
		$distroy.show()
		$distroy.play()
		if Global.current_score >= int(Global.high_score):
			Global._set_h_s(Global.current_score);
	

func _on_distroy_animation_finished():
	Global.game_over = true;
	
