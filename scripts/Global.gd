extends Node

var player_index = 0;
var game_speed = 25;
var current_score;
var high_score = 0 setget _set_h_s;
var player_health = 100;
var player_fire_damage = 0; # change in fire Main_Scene.gd to change realtime with powerups
var player_c_health = 0;
var boss_health = 3000;
var enemy_damage = 0;
var enemy_c_health = 0;
var fire_type = 0;
var movement_speed = 0.3;
var story_mode = false ;

var curr_level = 0;

var game_over = false;

onready var x_ratio;
onready var y_ratio;
onready var global_ratio;

var h_s_file = File.new()
var high_score_path = "user://HS.data" 



func _ready():
	
#	if not h_s_file.file_exists(high_score_path):
#		_write_file(high_score_path,str(high_score));
#	_write_file(high_score_path,str(0));
	
	high_score = int(_read_file(high_score_path));
	
	x_ratio = _get_viewport_rect().x/480;
	y_ratio = _get_viewport_rect().y/640;
	
	global_ratio = Vector2(x_ratio,y_ratio);
	

func _get_viewport_rect():
	return get_viewport().get_visible_rect().size
	

func _read_file(path):
	var file = File.new();
	if not file.file_exists(high_score_path) : 
		_write_file(high_score_path,str(high_score));
		
	
	file.open(path, File.READ);
	var data = file.get_as_text();
	file.close();
	return data;
	

func _write_file(path,towrite):
	var file = File.new();
	file.open(path, File.WRITE);
	file.store_string(towrite);
	file.close();
	

func _set_h_s(new_value):
	high_score = int(new_value);
	_write_file(high_score_path,str(high_score));
	

#func _get_h_s():
#	return _read_file(high_score_path);
