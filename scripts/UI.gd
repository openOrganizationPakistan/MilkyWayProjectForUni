#script:ui
extends Container

export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
onready var score_scn = $Score;
onready var v_box_container = $VBoxContainer;
onready var mode_button = $VBoxContainer/ModeButton;
onready var player_button = $VBoxContainer/PlayerButton;
onready var difficulty_button = $VBoxContainer/DifficultyButton;
onready var play_button = $VBoxContainer/PlayButton;

var sound_loop;
var score;

func _ready():
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
	score_scn._set_score("High Score: " , Global.high_score);
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
	
func _on_Button_pressed():
	#reset values to default
	Global.current_score= 0;
	Global.enemy_c_health= 0;
	Global.byte_array[0] = 0;
	Global.byte_array[9] = 0;
	Global.byte_array[8] = 25;
	Global.byte_array[16] = 0;
	Global.byte_array[19] += 1;
	Global.byte_array[13] = 1;
	Global.byte_array[26] = 7;
	Global.bullets = 0;
	print_stray_nodes();
	var _levels_scn = get_tree().change_scene("res://Scenes/Main_Scene.tscn");
#	Global.byte_array[1] = index;
	
func _on_MenuButton_item_selected(index):
	Global.byte_array[1] = index;
	if index == 0:
		Global.byte_array[9] = 8;
	
func _on_MenuButton2_item_selected(index):
	Global.byte_array[7] = index;
	
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
	
func _on_button_pressed():
	match Global.byte_array[38]:
		1:
			sound_loop = $sounds/click_01.stream as AudioStreamOGGVorbis;
			sound_loop.loop = false
			$sounds/click_01.play();
	
func _on_PlayButton_focus_entered():
	match Global.byte_array[38]:
		1:
			sound_loop = $sounds/click_02.stream as AudioStreamOGGVorbis;
			sound_loop.loop = false;
			$sounds/click_02.play();
	
func _on_soundButton_toggled(button_pressed):
	if not button_pressed:
		Global.byte_array[38] = 1;
		$sounds/music.play();
	else:
		Global.byte_array[38] = 0;
		$sounds/music.stop();
