extends Node2D

export (PackedScene) var main_levels_scn = preload("res://Scenes/Levels/Levels_main.tscn");
export (PackedScene) var main_players_scn = preload("res://Scenes/Players/Player_01.tscn");
export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/player_fire_01.tscn");
export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
onready var score_scn = $Control/Score;

export var fire_matrix = 1;

var player ;
onready var p_health_indic  = $Control/phealth;
onready var e_health_indic  = $Control/ehealth;
onready var cpu  = $Control/cpu;
#onready var mem  = $Control/mem;
onready var fps  = $Control/fps;

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
	

func _process(_delta):
	var score = Global.current_score;
	score_scn._set_score("Score: ",score);
	
	p_health_indic.text = "Health: " + str(player.health);
	e_health_indic.text = "enemy health: " + str(Global.enemy_c_health);
	
	cpu.text = "CPU: " + str(floor(Performance.get_monitor(1)*1000)) + " ms";
#	mem.text = "RAM: " + str(floor(Performance.get_monitor(3)/(1024*1024))) + "MB";
	fps.text = "FPS: " + str(Performance.get_monitor(0));
	
#	if Global.game_over:
#		if Global.current_score >= int(Global.high_score):
#			Global.set_h_s(score);
#
#
#		var _ui_scn = get_tree().change_scene("res://Scenes/UI.tscn");
#		queue_free();
		
	

func _on_player_fire_timer_timeout():
	
#	var fire = [main_fires_scn.instance()];
	var fire = [];
	
	for i in range (fire_matrix):
		fire.append(main_fires_scn.instance())
		fire[i].global_position = player.position + Vector2(0,-50);
		if i%3==0 and !i==0:
			fire[i].set_velocity((i/3)*25);
#			fire[i].global_position = player.position + Vector2(i/3*25,-50);
			
		elif i==0:
			fire[0].set_velocity(0);
#			fire[i].global_position = player.position + Vector2(0,-50);
		else:
			if i==1:
				fire[i].set_velocity(i*-25);
#				fire[i].global_position = player.position + Vector2(i*-25,-50);
			else:
				fire[i].set_velocity(((i/2)+1)*-25);
#				fire[i].global_position = player.position + Vector2((((i/2)+1)*-25),-50);
			
			
		add_child(fire[i]);
	
