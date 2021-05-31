#scripts:main_scene
#extends Node2D
extends Container
###################### creating variables #########################
export (PackedScene) var main_levels_scn = preload("res://Scenes/Levels_main.tscn");
export (PackedScene) var main_players_scn = preload("res://Scenes/Players/Players_Main.tscn");
export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/Player_Fires_Main.tscn");
export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
export (PackedScene) var main_power_up_scn = preload("res://Scenes/Miscs/Power_ups_main.tscn")
export (float,1,60) var power_ups_min_timer ;
export (float,5,240) var power_ups_max_timer ;

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
onready var status_hud = $VBoxContainer/status_hud/status_hud2;
onready var mem = $VBoxContainer/status_hud/status_hud2/mem;
onready var cpu = $VBoxContainer/status_hud/status_hud2/cpu;
onready var fps = $VBoxContainer/status_hud/status_hud2/fps;
onready var play_count = $VBoxContainer/status_hud/status_hud2/play_count;

var player ;
var temp_fire = main_fires_scn.instance();
var laser_loop;
var distroy_loop;
var win_loop;
var lose_loop;
var high_score_loop;
############################################################################################

########################## _ready function starts when the scene loading ###################
func _ready():
	#Reseting everything so the experience is consistant every time user plays game.
	##################### sounds properties ##########################
	laser_loop = $sounds/player_laser.stream as AudioStreamOGGVorbis;
	laser_loop.loop = false;
	distroy_loop = $sounds/distroy.stream as AudioStreamOGGVorbis;
	distroy_loop.loop = false;
	win_loop = $sounds/you_win.stream as AudioStreamOGGVorbis;
	win_loop.loop = false;
	lose_loop = $sounds/you_lose.stream as AudioStreamOGGVorbis;
	lose_loop.loop = false;
	high_score_loop = $sounds/high_score.stream as AudioStreamOGGVorbis;
	high_score_loop.loop = false;
	##################################################################
	###################### power ups time values storing in variable #
	power_ups_min_timer = Global.byte_array[33];
	power_ups_max_timer = Global.byte_array[34];
#	$VBoxContainer/statusContainer/soundButton.pressed = bool(Global.byte_array[38]);
	###################### checking for the sound mute button ###########
	match Global.byte_array[38]:
		1:
			$sounds/music.play()
			$sounds/music.volume_db = -15;
	##################################################################
	Global.byte_array[37] = 0;
	Global.byte_array[36] = 1;
	randomize();
	###################### sdynamic screen adjustment at loading time ####
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
	###################################################################
	power_ups_timer.wait_time = power_ups_min_timer;
	power_ups_timer.start();
	var bg = bg_env_scn.instance();
	add_child(bg);
	_add_player();
	_add_level();
	
########################### process is called every frame ###
func _process(_delta):
#	print_stray_nodes(); # to see if any memory leaks occure. ##########
#	p_health_indic.text = "Health: " + str(Global.byte_array[6]-50); 	# Global.palyer_c_health p_health_inidc was a label which showed text instead of graphical bars.
	p_health_bar.value = Global.byte_array[6] - 50 #Global.byte_array[6] contains player's current health.
	########### below three lines for debugging purpose and to see cpu times and mamory leaks and fps perfomance
#	cpu.text = "CPU: " + str(floor(Performance.get_monitor(1)*1000)) + " ms";
#	mem.text = "Orphans: " + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT));
#	fps.text = "FPS: " + str(Performance.get_monitor(0));

########### checking for sound again but 36th array elemet is indicating engine sound of player. player health end ######
	if Global.byte_array[36] == 0:
		if not $sounds/distroy.playing :
			match Global.byte_array[38]:
				1:
					$sounds/engine.stop();
					$sounds/distroy.play();
					print("distroyed sound");
	if Global.byte_array[36] == 1:
		if not $sounds/engine.playing :
			match Global.byte_array[38]:
				1:
					$sounds/engine.play();
					$sounds/distroy.stop();
					print("engine sound");
######################################################
##################### checking for game mode ####
	match (Global.byte_array[1]):
		0:
			if Global.integer_array[1] == 0:
				_display_message("Level 1");
				player_fire_timer.wait_time =  0.15;
			elif Global.integer_array[1] == 50:
				_display_message("Level 2");
				_update_speed_with_level();
			elif Global.integer_array[1] == 150:
				_display_message("Level 3");
				_update_speed_with_level();
			elif Global.integer_array[1] == 450:
				_display_message("Level 4");
				_update_speed_with_level();
			elif Global.integer_array[1] == 750:
				_display_message("Final\nBoss!!!");
				_update_speed_with_level();
		1:
			if (Global.integer_array[1] == 0):
				return;
			if (Global.integer_array[1] % 20 == 0):
				_update_speed_with_level();
	
################### updating level 
func _update_speed_with_level():
	Global.byte_array[8] += Global.integer_array[5] ;
	Global.integer_array[1] += 1;
	Global._update_todda_speed();
	print(Global.byte_array[8]);
	if (player_fire_timer.wait_time >0.1):
		player_fire_timer.wait_time -=  0.01
	
################################################
##################### loading main level #######
func _add_level():
	var temp = main_levels_scn.instance();
	add_child(temp);
	
################################################
################### adding player ##############
func _add_player():
	var temp = main_players_scn.instance();
	player = temp._get_player(Global.byte_array[7]); # get player index and spawn accordingly
	temp.queue_free();
	player.position = Vector2(240,320) * Global.universal_scale; # center of the screen
	add_child(player);
	match Global.byte_array[38]:
		1:
			$sounds/engine.play();
	
###############################################
################### player fires ##############
func _on_player_fire_timer_timeout():
	_show_hud();
	var fire = [];
	if (
		Global.byte_array[25] == 1
#		and Global.integer_array[4] > 0 
		and Global.byte_array[6] > 51	# It means player's current health is greater than 0 since bytes donot allow negative numbers so using limit 50-150 instead of 0-100 to overcome issue of health accidiental regeneration but remember to keep all damages less than 51 at any cost if damage exceed 51 it may cause the same glitch or error or bug or whatever.
		and Global.byte_array[22] != 0
		):
		match Global.byte_array[2]: # works as Global.fire_type Read Global script to know y its done.
			0:
				_spread_fire(fire);
#				_laser(fire)
			1:
				pass;
	
		######### logic for proceedural firespreading ######
func _spread_fire(fire):
	match Global.byte_array[16]:
		0:
			for i in (Global.byte_array[13]):
				match Global.byte_array[38]:
					1:
						$sounds/player_laser.play();
				fire.append(temp_fire._get_player_fire(Global.byte_array[2]));
				fire[i].position = player.position + Vector2(0,-50 * Global.x_ratio);
				if (i==0):
					fire[i].rotation = deg2rad(i);
					fire[i]._set_velocity(i);
				elif i>0 and Global.integer_array[4]>0:
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
				match Global.byte_array[38]:
					1:
						$sounds/player_laser.play();
				fire.append(temp_fire._get_player_fire(Global.byte_array[2]));
				var x_pos = Vector2(0,-50 * Global.x_ratio);
				match Global.byte_array[7]:
					0:
						if (i==0b0):
							x_pos.x = i;
						elif i>0 and Global.integer_array[4]>0:
							if (i==0b01):
								x_pos.x = (i*- (Global.byte_array[14] * Global.x_ratio));
							elif (i%0b10==0b0):
								x_pos.x = ((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
							elif (i%0b10==0b01):
								x_pos.x = ((0b10*i/3.0)* -(Global.byte_array[14] * Global.x_ratio));
					1:
						if (i==0b0):
							x_pos.x = i;
						elif i>0 and Global.integer_array[4]>0:
							x_pos.y = -10 * Global.x_ratio;
							if (i==0b01):
								x_pos.x = (i*- (Global.byte_array[14] * Global.x_ratio));
							elif (i%0b10==0b0):
								x_pos.x = ((i/2.0)* (Global.byte_array[14] * Global.x_ratio));
							elif (i%0b10==0b01):
								x_pos.x = ((0b10*i/3.0)* -(Global.byte_array[14] * Global.x_ratio));
				fire[i].position = player.position + x_pos ;
				add_child(fire[i]);
	
###########################################
########### update hud during gameplay ####
func _show_hud():
	if Global.integer_array[4] == 0:
		bullet_count_label_inf.show();
		bullet_count_label_num.hide();
	else:
		bullet_count_label_inf.hide();
		bullet_count_label_num.show();
		bullet_count_label_num.text = str(Global.integer_array[4])
		label_2.hide();
	var score = PoolIntArray() ;
	score.append(Global.integer_array[1]);
	score_scn._set_score("Score: ",score[0]);
#	e_health_indic.text = "enemy health: " + str(Global.enemy_c_health);
	if Global.byte_array[0] == 1:
		add_child(temp_fire);
		temp_fire.queue_free();
		player_fire_timer.stop();
		var text = "You\nWin!!!";
		if Global.byte_array[26] <5 :
			match Global.byte_array[38]:
				1:
					if not $sounds/you_lose.playing:
						$sounds/you_lose.play();
			text = "You\nLose!!!";
		else:
			match Global.byte_array[38]:
				1:
					if not $sounds/you_win.playing:
						$sounds/you_win.play();
		label.text = text;
		label.show();
		message_timer.start();
	if Global.byte_array[6] < 1:
		player_fire_timer.stop();
	
##########################################################
############ instancing a powerup on timeout #############
func _on_power_ups_timer_timeout():
	power_ups_timer.wait_time = rand_range(power_ups_min_timer,power_ups_max_timer);
	var temp_instance = main_power_up_scn.instance();
	var power_up = temp_instance._get_power_up( int(rand_range(0,Global.byte_array[15]) ) );
#	add_child(temp_instance)
	temp_instance.queue_free();
	path_follow.offset = randi();
	power_up.position = path_follow.position;
	add_child(power_up);
	
###########################################################
########### changing to main menu after gameover delay#####
func _on_message_timer_timeout():
	var _temp = get_tree().change_scene("res://Scenes/UI.tscn");
	
###########################################################
################# hiding message indicating level #########
func _on_level_changed_timeout():
	label.hide();
	
###########################################################
############### Showing message ###########################
func _display_message(message):
	Global.integer_array[1] +=1 ;
	label.text= str(message);
	label.show();
	level_changed_timer.start();
	
###########################################################
############## pause button ###############################
func _on_Button_toggled(button_pressed):
	if button_pressed:
		$VBoxContainer/statusContainer/Button.text = str("D");
		label_2.text="PAUSED!";
		label_2.show();
		get_tree().paused = true;
		return;
	$VBoxContainer/statusContainer/Button.text = str(" I I ");
	label_2.hide();
	get_tree().paused = false;
	
############### back button ###################################
func _on_Button2_pressed():
	var _temp = get_tree().change_scene("res://Scenes/UI.tscn");
	
###############################################################
