#script:ui
extends Container

################ variables initialization and declaration ###############
export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
onready var score_scn = $Score;
onready var v_box_container = $VBoxContainer;
onready var mode_button = $VBoxContainer/ModeButton;
onready var player_button = $VBoxContainer/PlayerButton;
onready var difficulty_button = $VBoxContainer/DifficultyButton;
onready var play_button = $VBoxContainer/PlayButton;

var sound_loop;
var score = 0;
var spd_tmp_fac = PoolRealArray();

############## _ready starts at loading time ##################
func _ready():
	spd_tmp_fac.append(3);
	if Global.byte_array[1] == 1:
		spd_tmp_fac[0] = 2;
	$soundButton.rect_scale = Vector2(Global.x_ratio,Global.x_ratio)*2;
	match Global.byte_array[38]:
		1:
			$sounds/music.play();
	v_box_container.rect_scale = Vector2(Global.x_ratio,Global.x_ratio)
	var v_b_c_scale = v_box_container.rect_scale;
	v_box_container.rect_global_position = (
		((Vector2(240,320)
		* Global.global_ratio)) 
		- (v_box_container.rect_size/2 * v_b_c_scale)
	);
	score_scn._set_score("High Score: " , Global.integer_array[2]);
	var bg = bg_env_scn.instance();
	add_child(bg);
#	ensures that variable value is idicated by GUI;
	mode_button.select(Global.byte_array[1]);
	player_button.select(Global.byte_array[7]);
	difficulty_button.select(Global.byte_array[35]);
	if Global.byte_array[37] == 1:
		match Global.byte_array[38]:
			1:
				if not $sounds/high_score.playing:
					$sounds/high_score.play();
	$soundButton.pressed = not bool(Global.byte_array[38]);
	_calc_spd_inc_fac(Global.byte_array[35]);
	
############# play button pressed actions ########
func _on_Button_pressed():
	#reset values to default
	Global.integer_array[1]= 0;
#	Global.enemy_c_health= 0;
	Global.byte_array[0] = 0;
	Global.byte_array[9] = 0;
	Global.byte_array[8] = 16;
	Global.byte_array[16] = 0;
	Global.byte_array[19] += 1;
	Global.byte_array[13] = 1;
	Global.byte_array[26] = 7;
	Global.integer_array[4] = 0;
	var _levels_scn = get_tree().change_scene("res://Scenes/Main_Scene.tscn");
#	Global.byte_array[1] = index;
	
############################################################################
############### on_MenuButton_item_selected is connected to game mode #
func _on_MenuButton_item_selected(index):
	Global.byte_array[1] = index;
	spd_tmp_fac[0] = 2;
	if index == 0:
		 spd_tmp_fac[0] = 3;
	print(spd_tmp_fac[0]);
	_calc_spd_inc_fac(Global.byte_array[35]);
	print (Global.integer_array[5]);
	print(Global.byte_array[8]);
	
func _on_MenuButton2_item_selected(index):
	Global.byte_array[7] = index;
	
################### Game difficulty ##########
func _on_MenuButton3_item_selected(index):
	Global.byte_array[33] = (index + 1) * 30;
#	Global.byte_array[33] = (index + 1) * 1;
	Global.byte_array[34] = (index + 1) * 90;
#	Global.byte_array[34] = (index + 1) * 5;
	Global.byte_array[5] = (15) / (index + 1);
	Global.byte_array[21] = (5) * (index +1);
	Global.byte_array[28] = Global.byte_array[21];
	Global.byte_array[11] = (10) * (index +1);
	Global.byte_array[32] = 50 + (20 * (index + 1));
	Global.byte_array[35] = (index);
	_calc_spd_inc_fac(index);
	print (Global.integer_array[5]);
	print(Global.byte_array[8]);
	
########### calculate speed increament factor ##########
func _calc_spd_inc_fac(index):
	Global.integer_array[5] = (spd_tmp_fac[0] * (index + 1)) * abs(Global.byte_array[1]-(2-(Global.byte_array[1]-1)));
	
########### play button sound #######
func _on_button_pressed():
	match Global.byte_array[38]:
		1:
			sound_loop = $sounds/click_01.stream as AudioStreamOGGVorbis;
			sound_loop.loop = false
			$sounds/click_01.play();
	
#######################################

############### mute button ################3
func _on_soundButton_toggled(button_pressed):
	if not button_pressed:
		Global.byte_array[38] = 1;
		$sounds/music.play();
	else:
		Global.byte_array[38] = 0;
		$sounds/music.stop();
