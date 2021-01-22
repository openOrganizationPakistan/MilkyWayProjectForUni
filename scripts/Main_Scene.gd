extends Node2D

export (PackedScene) var main_levels_scn = preload("res://Scenes/Levels/Levels_main.tscn");
export (PackedScene) var main_players_scn = preload("res://Scenes/Players/Players_Main.tscn");
export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/Player_Fires_Main.tscn");
export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
export (PackedScene) var main_power_up_scn = preload("res://Scenes/Miscs/Power_ups_main.tscn")


onready var score_scn = $Control/Score;
onready var p_health_indic  = $Control/phealth;
onready var e_health_indic  = $Control/ehealth;
onready var cpu  = $Control/cpu;
onready var mem  = $Control/mem;
onready var fps  = $Control/fps;
onready var path_follow = $Path2D/PathFollow2D;
onready var label = $Label;

var player ;
var temp_fire = main_fires_scn.instance();

func _process(_delta):
	p_health_indic.text = "Health: " + str(Global.byte_array[6]-50); 	# Global.palyer_c_health
	
	cpu.text = "CPU: " + str(floor(Performance.get_monitor(1)*1000)) + " ms";
	mem.text = "Orphans: " + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT));
	fps.text = "FPS: " + str(Performance.get_monitor(0));
	
	

func _ready():
	label.rect_position = Vector2(240 * Global.x_ratio,
			320 * Global.y_ratio
		) - Vector2(label.rect_size.x/2, label.rect_size.y/2) ;
	
	
	
	$power_ups_timer.wait_time = 60;
	$power_ups_timer.start();
	
	var bg = bg_env_scn.instance();
	add_child(bg);
	
	$Control.rect_size.x = 480*Global.x_ratio;
	
	_add_player();
	
	_add_level();
	
	var fire_damage;
	
	match Global.byte_array[2]:	#fire_type
		0:
			fire_damage = 5;
		
	
	Global.byte_array[5] = fire_damage;
	

func _add_level():
	var temp = main_levels_scn.instance();
	add_child(temp);
	

func _add_player():
	var temp = main_players_scn.instance();
	player = temp._get_player(Global.byte_array[7]);
	temp.queue_free();
	player.position = Vector2(240,320) * Vector2(Global.x_ratio,Global.y_ratio);
	add_child(player);
	

func _on_player_fire_timer_timeout():
	_show_hud();
	
#	var fire = [main_fires_scn.instance()];
	var fire = [];
	
	if Global.byte_array[6] > 51:	# It means player's current health is greater than 0 since bytes donot allow negative numbers so using limit 50-150 instead of 0-100
		
		match Global.byte_array[2]: # Global.fire_type
			0:
				_spread_fire(fire);
#				_laser(fire)
				
			1:
				pass;
				
			
		
	

func _spread_fire(fire):
	
	match Global.byte_array[16]:
		0:
			for i in range (Global.byte_array[13]):
				fire.append(temp_fire._get_player_fire(Global.byte_array[2]) );
				fire[i].position = player.position + Vector2(0,-50 * Global.x_ratio) ;
				if (i==0):
					fire[i]._set_velocity(i);
				elif (i==1):
					fire[i]._set_velocity(i*- (Global.byte_array[14] * Global.x_ratio));
				elif (i%2==0):
					fire[i]._set_velocity((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
				elif (i%2==1):
					fire[i]._set_velocity((2*i/3.0)* -(Global.byte_array[14] * Global.x_ratio));
				
				add_child(fire[i]);
			
		1:
			for i in range (Global.byte_array[13]):
				fire.append(temp_fire._get_player_fire(Global.byte_array[2]) );
				var x_pos
				if (i==0b0):
					x_pos = (i);
				elif (i==0b01):
					x_pos = (i*- (Global.byte_array[14] * Global.x_ratio));
				elif (i%0b10==0b0):
					x_pos = ((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
				elif (i%0b10==0b01):
					x_pos = ((0b10*i/3.0)* -(Global.byte_array[14] * Global.x_ratio));
				
				fire[i].position = player.position + Vector2(x_pos,-50 * Global.x_ratio) ;
				
				add_child(fire[i]);
				
			
		
	

func _show_hud():
	var score = Global.current_score;
	score_scn._set_score("Score: ",score);
	
	e_health_indic.text = "enemy health: " + str(Global.enemy_c_health);
	
	if Global.byte_array[0] == 1:
	
		$player_fire_timer.stop();
		
		var text = "You\nWin!!!";
		
		if Global.byte_array[6] <51 :
			text = "You\nLose!!!";
		
		label.text = text;
		label.show();
		$message_timer.start();
	
	if Global.byte_array[6] < 1:
		$player_fire_timer.stop();
		
	match Global.byte_array[1]:
		0:
			pass;
		1:
			match Global.current_score:
				0:
					_display_message("Level 1");
				50:
					_display_message("Level 2");
				150:
					_display_message("Level 3");
				450:
					_display_message("Level 4");
				750:
					_display_message("Final\nBoss!!!");
			


func _on_power_ups_timer_timeout():
	$power_ups_timer.wait_time = rand_range(120,180);
	var temp_instance = main_power_up_scn.instance();
	var power_up = temp_instance._get_power_up( floor(rand_range(0,Global.byte_array[15]) ) );
	temp_instance.queue_free();
	path_follow.offset = randi();
	power_up.position = path_follow.position;
	add_child(power_up);
	print("test");
	

func _on_message_timer_timeout():
	temp_fire.queue_free();
	var _temp = get_tree().change_scene("res://Scenes/UI.tscn");
	

func _on_level_changed_timeout():
	label.hide();
	

func _display_message(message):
	Global.current_score +=1 ;
	label.text= str(message);
	label.show();
	$level_changed.start();
