#scripts:main_scene
#extends Node2D
extends Container


export (PackedScene) var main_levels_scn = preload("res://Scenes/Levels/Levels_main.tscn");
export (PackedScene) var main_players_scn = preload("res://Scenes/Players/Players_Main.tscn");
export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/Player_Fires_Main.tscn");
export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
export (PackedScene) var main_power_up_scn = preload("res://Scenes/Miscs/Power_ups_main.tscn")
export (PackedScene) var heart_tex_scn = preload("res://Scenes/Miscs/heart_tex.tscn");

onready var score_scn = $VBoxContainer/statusContainer/Score;
onready var path_follow = $Node2D/Path2D/PathFollow2D;
onready var label = $Node2D/Label;
onready var label_2 = $Node2D/Label2;
onready var p_health_bar = $VBoxContainer/statusContainer/pHealthBar;
onready var path = $Node2D/Path2D;
onready var power_ups_timer = $Node2D/power_ups_timer;
onready var level_changed_timer = $Node2D/level_changed;
onready var node2d = $Node2D;
onready var player_fire_timer = $Node2D/player_fire_timer;
onready var message_timer = $Node2D/message_timer;
onready var bullet_count_label_inf = $VBoxContainer/status_hud/HBoxContainer2/bullet_count;
onready var bullet_count_label_num = $VBoxContainer/status_hud/HBoxContainer2/bullet_count2;
onready var heart_placer = $VBoxContainer/status_hud/heartsContainer;
onready var status_hud = $VBoxContainer/status_hud/status_hud2;
onready var mem = $VBoxContainer/status_hud/status_hud2/mem;
onready var cpu = $VBoxContainer/status_hud/status_hud2/cpu;
onready var fps = $VBoxContainer/status_hud/status_hud2/fps;
onready var play_count = $VBoxContainer/status_hud/status_hud2/play_count;

var player ;
var temp_fire = main_fires_scn.instance();

func _ready():
	randomize();
	$Control2.rect_scale=Global.universal_scale;
	path.curve.set_point_position(1, Vector2(Global._get_viewport_rect().x - 50, -15) );
	print(path.curve.get_point_position(1));
	play_count.text = "play count: " + str(Global.byte_array[19]);
	label.rect_position = Vector2(240 * Global.x_ratio,
			320 * Global.y_ratio
		) - Vector2(label.rect_size.x/2, label.rect_size.y/2) ;
	label_2.text = "Paused"
	label_2.rect_position = Vector2(240 * Global.x_ratio,
			320 * Global.y_ratio
		) - Vector2(label_2.rect_size.x/2, label_2.rect_size.y/2) ;
	
	p_health_bar.anchor_right = 0.5;
	power_ups_timer.wait_time = 60;
	power_ups_timer.start();
	
	var bg = bg_env_scn.instance();
	add_child(bg);
	_add_player();
	_add_level();
	
func _process(_delta):
#	p_health_indic.text = "Health: " + str(Global.byte_array[6]-50); 	# Global.palyer_c_health
	p_health_bar.value = Global.byte_array[6] - 50
	cpu.text = "CPU: " + str(floor(Performance.get_monitor(1)*1000)) + " ms";
	mem.text = "Orphans: " + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT));
	fps.text = "FPS: " + str(Performance.get_monitor(0));
	
func _add_level():
	var temp = main_levels_scn.instance();
	add_child(temp);
	
func _add_player():
	var temp = main_players_scn.instance();
	player = temp._get_player(Global.byte_array[7]); # get player index
	temp.queue_free();
	player.position = Vector2(240,320) * Global.universal_scale;
	add_child(player);
	
func _on_player_fire_timer_timeout():
	_show_hud();
	var fire = [];
	if (
		Global.byte_array[25] == 1
#		Global.bullets > 0 
		and 
		Global.byte_array[6] > 51	# It means player's current health is greater than 0 since bytes donot allow negative numbers so using limit 50-150 instead of 0-100 to overcome issue of health accidiental regeneration but remember to keep all damages less than 51 at any cost if damage exceed 51 it may cause the same glitch or error or but or whatever.
		and Global.byte_array[22] != 0
		):
		match Global.byte_array[2]: # works as Global.fire_type Read Global script to know y its done.
			0:
				_spread_fire(fire);
#				_laser(fire)
			1:
				pass;
	
func _spread_fire(fire):
	match Global.byte_array[16]:
		0:
			for i in (Global.byte_array[13]):
				fire.append(temp_fire._get_player_fire(Global.byte_array[2]) );
				fire[i].position = player.position + Vector2(0,-50 * Global.x_ratio);
				if (i==0):
					fire[i].rotation = deg2rad(i);
					fire[i]._set_velocity(i);
					
				elif i>0 and Global.bullets>0:
					if (i==1):
						fire[i]._set_velocity(i*- (Global.byte_array[14] * Global.x_ratio));
						fire[i].rotation = deg2rad(1.4*Global.x_ratio);
#						print((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
						
					elif (i%2==0):
						fire[i]._set_velocity((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
						fire[i].rotation = deg2rad(-1.4*Global.x_ratio*i);
#						print((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
						
					elif (i%2==1):
						fire[i]._set_velocity((2*i/3.0)* -(Global.byte_array[14] * Global.x_ratio));
						fire[i].rotation = deg2rad(1.4*Global.x_ratio*i);
#						print((2*i/3.0)* -(Global.byte_array[14] * Global.x_ratio));
						
				
				add_child(fire[i]);
			
		1:
			for i in (Global.byte_array[13]):
				fire.append(temp_fire._get_player_fire(Global.byte_array[2]) );
				var x_pos = 0
				if (i==0b0):
					x_pos = i;
				elif i>0 and Global.bullets>0:
					if (i==0b01):
						x_pos = (i*- (Global.byte_array[14] * Global.x_ratio));
					elif (i%0b10==0b0):
						x_pos = ((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
					elif (i%0b10==0b01):
						x_pos = ((0b10*i/3.0)* -(Global.byte_array[14] * Global.x_ratio));
					
				fire[i].position = player.position + Vector2(x_pos,-50 * Global.x_ratio) ;
				
				add_child(fire[i]);

func _show_hud():
	if Global.bullets == 0:
		bullet_count_label_inf.show();
		bullet_count_label_num.hide();
	else:
		bullet_count_label_inf.hide();
		bullet_count_label_num.show();
		bullet_count_label_num.text = str(Global.bullets)
	
	if Global.byte_array[25] == 0:
		label_2.text="PAUSED!";
		label_2.show();
	else:
		label_2.hide();
	
	var score = Global.current_score ;
	score_scn._set_score("Score: ",score);
	
#	e_health_indic.text = "enemy health: " + str(Global.enemy_c_health);
	
	if Global.byte_array[0] == 1:
	
		player_fire_timer.stop();
		
		var text = "You\nWin!!!";
		
		if Global.byte_array[26] <5 :
			text = "You\nLose!!!";
		
		label.text = text;
		label.show();
		message_timer.start();
	
	if Global.byte_array[6] < 1:
		player_fire_timer.stop();
		
	match Global.byte_array[1]:
		0:
			if Global.current_score == 50:
				_display_message("Game\nSpeed\n\t+10")
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;
				Global._update_todda_speed();
			elif Global.current_score == 150:
				_display_message("Game\nSpeed\n\t+10")
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;
				Global._update_todda_speed();
			elif Global.current_score == 450:
				_display_message("Game\nSpeed\n\t+10")
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;
				Global._update_todda_speed();
			elif Global.current_score == 750:
				_display_message("Game\nSpeed\n\t+10")
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;
				Global._update_todda_speed();
			pass;
		1:
			if Global.current_score == 0:
				_display_message("Level 1");
			elif Global.current_score == 50:
				_display_message("Level 2");
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;
				Global._update_todda_speed();
			elif Global.current_score == 150:
				_display_message("Level 3");
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;
				Global._update_todda_speed();
			elif Global.current_score == 450:
				_display_message("Level 4");
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;
				Global._update_todda_speed();
			elif Global.current_score == 750:
				_display_message("Final\nBoss!!!");
				_display_message("Game\nSpeed\n\t+10")
				Global.byte_array[8] += 10 ;
				Global.byte_array[24] += 10 ;
				Global.current_score += 1;

func _on_power_ups_timer_timeout():
	power_ups_timer.wait_time = rand_range(120,180);
	var temp_instance = main_power_up_scn.instance();
	var power_up = temp_instance._get_power_up( int(rand_range(0,Global.byte_array[15]) ) );
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
	level_changed_timer.start();

func _on_Button_toggled(button_pressed):
	if button_pressed:
		Global.byte_array[25] = 0;
		Global.byte_array[23] = 0;
		Global.byte_array[8] *= Global.byte_array[23]
		Global._update_todda_speed();
		
	else:
		Global.byte_array[25] = 1;
		Global.byte_array[23] = 1;
		Global.byte_array[8] = Global.byte_array[24]
		Global._update_todda_speed();
