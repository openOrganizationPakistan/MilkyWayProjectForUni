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
	Global.current_score=45;
	Global.byte_array[0] = 0; 
	Global.byte_array[2] = 0; 
	Global.byte_array[3] = 15; 
	Global.byte_array[4] = 150; 
	Global.byte_array[5] = 0; 
	Global.byte_array[6] = 150; 
#	Global.byte_array[8] = 25; 
	Global.byte_array[10] = 5; 
	Global.byte_array[11] = 50; 
	Global.byte_array[12] = 5; 
	Global.byte_array[13] = 1; 
	Global.byte_array[14] = 25; 
	Global.byte_array[15] = 3; 
	Global.byte_array[16] = 0; 
	
	var _levels_scn = get_tree().change_scene("res://Scenes/Main_Scene.tscn");
	

func _on_MenuButton_item_selected(index):
	Global.byte_array[1] = index;

			
	
