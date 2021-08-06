#scripts:levels_main
extends Node2D

export (PackedScene) var virus_scn = preload("res://Scenes/enemies/virus.tscn");
export (PackedScene) var boss_scn = preload("res://Scenes/enemies/Boss.tscn");
export (PackedScene) var todda_scn = preload("res://Scenes/enemies/todda.tscn");
export (PackedScene) var fighter_scn = preload("res://Scenes/enemies/figher.tscn");

var boss_timer_started;
onready var fighter_timer = $fighter_timer;
onready var virus_timer = $virus;
onready var todda_timer = $todda;
onready var path_follow_2d = $Path2D/PathFollow2D;

func _ready():
	$Path2D.curve.set_point_position(1, Vector2(Global._get_viewport_rect().x - 50, -15) );
	print($Path2D.curve.get_point_position(1))
	virus_timer.start();
	match Global.byte_array[1]:
		1:
			todda_timer.start();
			fighter_timer.start();
	
func _process(_delta):
	match Global.byte_array[1]:
		0:
			match Global.byte_array[9]:
				0:
					if Global.integer_array[1] > 49:
						Global.byte_array[9] += 1;
						todda_timer.start();
				1:
					if Global.integer_array[1] > 149:
						Global.byte_array[9] += 1;
						fighter_timer.start();
		#					$boss_commings.start();
				2:
					if Global.integer_array[1] > 349:
						Global.byte_array[9] += 1;
				3:
					if Global.integer_array[1] > 749:
						virus_timer.stop();
						todda_timer.stop();
						fighter_timer.stop();
						Global.byte_array[9] += 1;
						$boss_commings.start();
		1:
			pass;
	
func _instanciate_object(obj):
	path_follow_2d.offset = randi();
	var obj_instance = obj.instance();
	obj_instance.position = path_follow_2d.position;
	add_child(obj_instance);
	
func _on_virus_timeout():
	if Global.byte_array[0] == 1:
		queue_free();
	if not Global.byte_array[9] == 4 :
#		print("virus running");
		virus_timer.wait_time = rand_range(1,6);
		if Global.byte_array[25] == 1 :
			_instanciate_object(virus_scn);
		virus_timer.start();
	
func _load_boss():
	_instanciate_object(boss_scn);
	
func _on_boss_commings_timeout(): 
	_load_boss();

func _on_todda_timeout():
#	print("todda comming")
	todda_timer.wait_time = rand_range(5,10);
	if Global.byte_array[25] == 1:
		_instanciate_object(todda_scn);
#		todda_timer.wait_time( int(rand_range(randi()%(50/Global.byte_array[8]),randi()%(150/Global.byte_array[8])) ));
	todda_timer.start();
	
func _on_fighter_timer_timeout():
	fighter_timer.wait_time = rand_range(3,10);
	_instanciate_object(fighter_scn);
	fighter_timer.start();
