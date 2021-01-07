extends Node

var game_speed = 25;
var current_score=0;
var high_score = 0;
var player_health = 100;
var player_fire_damage = 0;
var boss_health = 1000;
var enemy_damage = 0;
var enemy_c_health = 0;

var game_over = false;

onready var x_ratio;
onready var y_ratio;

var h_s_file = File.new()
var high_score_path = "user://HS.nm" 



func _ready():
	
	if not h_s_file.file_exists(high_score_path):
		_write_file(high_score_path,str(high_score));
		
	
	high_score = _read_file(high_score_path);
	
	x_ratio = _get_viewport_rect().x/480;
	y_ratio = _get_viewport_rect().y/640;
	

func _get_viewport_rect():
	return get_viewport().get_visible_rect().size
	

func _read_file(path):
	var file = File.new();
	
	file.open(path, File.READ);
	var data = file.get_as_text();
	file.close();
	return data;
	

func _write_file(path,towrite):
	var file = File.new();
	file.open(path, File.WRITE);
	file.store_string(towrite);
	file.close();
	
