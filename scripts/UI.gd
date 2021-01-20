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
	

func _on_Button_pressed():
	Global.current_score= 45;
	Global.game_over=false;
	var _levels_scn = get_tree().change_scene("res://Scenes/Main_Scene.tscn");
	


func _on_MenuButton_item_selected(index):
	match index:
		0:
			Global.story_mode = false;
		1:
			Global.story_mode = true;
	pass # Replace with function body.
