extends Node2D

export (PackedScene) var main_levels_scn = preload("res://Scenes/Levels/Levels_main.tscn");
export (PackedScene) var main_players_scn = preload("res://Scenes/Players/Players_Main.tscn");
export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/Player_Fires_Main.tscn");
export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
export var fire_matrix = 1 ;
export var spread_fire = 30 ;

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
	
	_add_player();
	
	_add_level();
	
	match Global.fire_type:
		0:
			Global.player_fire_damage = 1;
		
	

func _add_level():
	var temp = main_levels_scn.instance();
	var level = temp._return_level(0);
	temp.queue_free();
	add_child(level);
	

func _add_player():
	var temp = main_players_scn.instance();
	player = temp._get_player(Global.player_index);
	temp.queue_free();
	player.position = Vector2(240,320) * Vector2(Global.x_ratio,Global.y_ratio);
	add_child(player);
	

func _on_player_fire_timer_timeout():
	_show_hud();
#	var fire = [main_fires_scn.instance()];
	var fire = [];
	
	match Global.fire_type:
		0:
			_spread_fire(fire);
			
		
	

func _spread_fire(fire):
	var temp = main_fires_scn.instance()
	for i in range (fire_matrix):
		fire.append(temp._get_player_fire(Global.fire_type) );
		fire[i].position = player.position + Vector2(0,-30 * Global.x_ratio) ;
		if (i==0):
			fire[i]._set_velocity(i);
		elif (i==1):
			fire[i]._set_velocity(i*- (spread_fire * Global.x_ratio));
		elif (i%2==0):
			fire[i]._set_velocity((i/2.0)* (spread_fire * Global.x_ratio));
		elif (i%2==1):
			fire[i]._set_velocity((2*i/3.0)* -(spread_fire * Global.x_ratio));
		
		add_child(fire[i]);
	temp.queue_free();
	

func _show_hud():
	var score = Global.current_score;
	score_scn._set_score("Score: ",score);
	
	e_health_indic.text = "enemy health: " + str(Global.enemy_c_health);
	
	if player.health <=0:
		if Global.current_score > Global.high_score:
			Global._set_h_s(Global.current_score);
		var _temp = get_tree().change_scene("res://Scenes/UI.tscn");
	

func _player_colide(_area):
	if Global.game_over:
		queue_free();
	pass
