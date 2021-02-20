#script: Global.
extends Node

var byte_array = PoolByteArray();

var movement_speed = 0.2;
var current_score=0b0;
var high_score = 0b0 setget _set_h_s;
var boss_health = 3000;
var enemy_c_health = 0b0;

var bullets = 250;

onready var x_ratio;
onready var y_ratio;
onready var global_ratio;

var h_s_file = File.new()
var high_score_path = "user://HS.data" 

var universal_scale = Vector2();

func _ready():
	
	
#	if not h_s_file.file_exists(high_score_path):
#		_write_file(high_score_path,str(high_score));
#	_write_file(high_score_path,str(0));


# Using byte array for all the tasks that requires
# numbers between 0 and 255 since var uses 8 bytes
# which results in perfomance loss and hence an 
# array of bytes may be difficult to work with but
# its very friendly to computer and actual size is
# more than the array size since it also has location
# and protocole standards of allocating memmory etc so
# declaring many of bytes individually is not a great
# choice its still better than var but I used array
# which is much much faster coz access time is pretty
# much direct, no recursive accesses and no perfomance
# loss and this the sceret souce to the game working
# with more than 50 FPS on 256MB RAM and dual core
# processor mobile phones as well (These test result 
# numbers are from my personal tests and can varry
# according to your equipments). 

	byte_array.append(0) 				# 0-game_over
	byte_array.append(0) 				# 1-game_mode
	byte_array.append(0) 				# 2-fire_type
	byte_array.append(15) 				# 3-boss_damage
	byte_array.append(150) 				# 4-player_health
	byte_array.append(5) 				# 5-player_fire_damage
	byte_array.append(150) 				# 6-player_c_health
	byte_array.append(0) 				# 7-player_index
	byte_array.append(25) 				# 8-game_speed
	byte_array.append(0)				# 9-current_level
	byte_array.append(5)				# 10-boss_fire_damage
	byte_array.append(50)				# 11-virus_damage
	byte_array.append(5)				# 12-enimy_ship_01_damage
	byte_array.append(1)				# 13-fire_matrix
	byte_array.append(25)				# 14-fire_spreading distance
	byte_array.append(3)				# 15-max_power_up_index
	byte_array.append(0)				# 16-current_power_type
	byte_array.append(1)				# 17-screen_touch index
	byte_array.append(1)				# 18-temp screen_touch index
	byte_array.append(0)				# 19-non-stop number of games
	byte_array.append(1)				# 20-todda ship speed
	byte_array.append(15)				# 21-todda ship damage to player
	byte_array.append(0)				# 22-fire button
	byte_array.append(1)				# 23-Global Speed Factor
	byte_array.append(byte_array[8])	# 24-Global Speed Constant
	byte_array.append(1)				# 25-timers allowation
	
	
	
	byte_array[20] = byte_array[8]/2 ;
	
	high_score = int(_read_file(high_score_path));
	
	x_ratio = _get_viewport_rect().x/480;
	y_ratio = _get_viewport_rect().y/640;
	
	global_ratio = Vector2(x_ratio,y_ratio);
#	fire_scale = Vector2(x_ratio,x_ratio);
	universal_scale = Vector2(x_ratio,x_ratio);
	

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
	

func _update_todda_speed():
	byte_array[20] = byte_array[8]/2;
