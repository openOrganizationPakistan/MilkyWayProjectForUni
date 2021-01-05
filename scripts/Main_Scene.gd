extends Node2D

export (PackedScene) var main_levels_scn = preload("res://Scenes/Levels/Levels_main.tscn");

export (PackedScene) var main_players_scn = preload("res://Scenes/Players/Player_01.tscn");

export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/player_fire_01.tscn");

var player ;
onready var p_health_indic  = $Control/phealth;
onready var e_health_indic  = $Control/ehealth;

func _ready():
	
	e_health_indic.rect_position.x = float(480/Global.x_ratio + e_health_indic.rect_size.x);
	
	player = main_players_scn.instance();
	player.position = Vector2(480,640) / 2;
	add_child(player);
	
	var level = main_levels_scn.instance();
	level._return_level(0);
	add_child(level);
	

func _process(_delta):
	p_health_indic.text = "Health: " + str(player.health);
	e_health_indic.text = "enemy health: " + str(Global.enemy_c_health);

func _on_player_fire_timer_timeout():
	var fire = main_fires_scn.instance();
	fire.global_position = player.position;
	add_child(fire);
	
