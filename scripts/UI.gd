extends Container

export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
onready var score_scn = $Score;
onready var v_box_container = $VBoxContainer;

var score;

func _ready():
	
	v_box_container.rect_scale = Vector2(Global.x_ratio,Global.x_ratio)
	
	var v_b_c_scale = v_box_container.rect_scale;
	
	v_box_container.rect_global_position = (
		((Vector2(240,480)
		* Global.global_ratio)) 
		- (v_box_container.rect_size/2 * v_b_c_scale)
	);
	
	score_scn._set_score("High Score: " , Global.high_score);
	
	var bg = bg_env_scn.instance();
	add_child(bg);
	
#	ensures that variable value is idicated by GUI;
	$VBoxContainer/MenuButton.select(Global.byte_array[1]);
	
	
	

func _on_Button_pressed():
	#reset values to default
	Global.current_score=0;
	Global.enemy_c_health=0;
	Global.byte_array[0] = 0;
	Global.byte_array[9] = 0;
	Global.byte_array[16] = 0; 
	Global.byte_array[19] += 1; 
	Global.byte_array[13] = 1;
	Global.bullets = 500; 
	
	var _levels_scn = get_tree().change_scene("res://Scenes/Main_Scene.tscn");
#	Global.byte_array[1] = index;

	
