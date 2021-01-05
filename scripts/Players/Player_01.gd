extends "res://scripts/Players/player_controls.gd"

var health = Global.player_health;

func _ready():
	scale = Vector2(0.4,0.4) * Global.x_ratio ;
	

func _process(_delta):
	if health <= 0:
		queue_free();

func _on_Player_01_area_entered(area):
	if area.is_in_group("enemy"):
		health -= Global.enemy_damage;
		
	
