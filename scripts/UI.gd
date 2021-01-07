extends Container

export (PackedScene) var bg_env_scn = preload("res://Scenes/env/BG_Particles.tscn");
onready var score_scn = $Score;

var score;

func _ready():
	$VBoxContainer.rect_global_position = (
		((Vector2(240,320)
		* Vector2(Global.x_ratio,Global.y_ratio))) 
		- $VBoxContainer.rect_size/2
	);
	
	
	score_scn._set_score("High Score: " , Global.high_score);
	
	var bg = bg_env_scn.instance();
	add_child(bg);
	

func _on_Button_pressed():
	Global.current_score=0;
	Global.game_over=false;
	var _levels_scn = get_tree().change_scene("res://Scenes/Main_Scene.tscn");
	
