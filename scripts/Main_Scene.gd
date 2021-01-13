extends Node2D

export (PackedScene) var main_levels_scn = preload("res://Scenes/Levels/Levels_main.tscn");
export (PackedScene) var main_players_scn = preload("res://Scenes/Players/Player_01.tscn");
export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/player_fire_01.tscn");
export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
export var fire_matrix = 1 ;

onready var score_scn = $Control/Score;
onready var p_health_indic  = $Control/phealth;
onready var e_health_indic  = $Control/ehealth;
onready var cpu  = $Control/cpu;
#onready var mem  = $Control/mem;
onready var fps  = $Control/fps;

var player ;

func _process(_delta):
	p_health_indic.text = "Health: " + str(Global.player_c_health);
	
	cpu.text = "CPU: " + str(floor(Performance.get_monitor(1)*1000)) + " ms";
#	mem.text = "RAM: " + str(floor(Performance.get_monitor(3)/(1024*1024))) + "MB";
	fps.text = "FPS: " + str(Performance.get_monitor(0));
	

func _ready():
	var bg = bg_env_scn.instance();
	add_child(bg);
	
	$Control.rect_size.x = 480*Global.x_ratio;
	
	player = main_players_scn.instance();
	player.position = Vector2(240,320) * Vector2(Global.x_ratio,Global.y_ratio);
	add_child(player);
	
	var level = main_levels_scn.instance();
	level._return_level(0);
	add_child(level);
	
	match Global.fire_type:
		0:
			Global.player_fire_damage = 3;
		
	

func _on_player_fire_timer_timeout():
	_show_hud();
#	var fire = [main_fires_scn.instance()];
	var fire = [];
	
	for i in range (fire_matrix):
		fire.append(main_fires_scn.instance())
		fire[i].position = player.position + Vector2(0,-45 * Global.x_ratio) ;
		if (i==0):
			fire[i].set_velocity(i);
		elif (i==1):
			fire[i].set_velocity(i*- (40 * Global.x_ratio));
		elif (i%2==0):
			fire[i].set_velocity(floor(i/2)* (40 * Global.x_ratio));
		elif (i%2==1):
			fire[i].set_velocity(floor(2*i/3)* -(40 * Global.x_ratio));
		
		add_child(fire[i]);
	

func _show_hud():
	var score = Global.current_score;
	score_scn._set_score("Score: ",score);
	
	e_health_indic.text = "enemy health: " + str(Global.enemy_c_health);
	
	if player.health <=0:
		if Global.current_score > Global.high_score:
			Global._set_h_s(Global.current_score);
		var _temp = get_tree().change_scene("res://Scenes/UI.tscn");
