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
		0:
			todda_timer.start();
			fighter_timer.start();
	
func _process(_delta):
	match Global.byte_array[1]:
		0:
			pass;
		1:
			match Global.byte_array[9]:
				0:
					if Global.current_score > 49:
						Global.byte_array[9] += 1;
						todda_timer.start();
				1:
					if Global.current_score > 149:
						Global.byte_array[9] += 1;
						fighter_timer.start();
		#					$boss_commings.start();
				2:
					if Global.current_score > 349:
						Global.byte_array[9] += 1;
				3:
					if Global.current_score > 749:
						virus_timer.stop();
						todda_timer.stop();
						fighter_timer.stop();
						Global.byte_array[9] += 1;
						$boss_commings.start();
	
func _on_virus_timeout():
	if Global.byte_array[0] == 1:
		queue_free();
	if not Global.byte_array[9] == 4 :
#		print("virus running");
		virus_timer.wait_time = 1 + rand_range(0,5);
		if Global.byte_array[25] == 1 :
			path_follow_2d.offset = randi();
			var virus_instance = virus_scn.instance();
			virus_instance.position = path_follow_2d.position;
			add_child(virus_instance);
		virus_timer.start();
	
func _load_boss():
	var boss = boss_scn.instance();
	path_follow_2d.offset = randi();
	boss.position = path_follow_2d.position;
	add_child(boss);
	
func _on_boss_commings_timeout():
	_load_boss();

func _on_todda_timeout():
#	print("todda comming")
	todda_timer.wait_time = rand_range(5,10);
	if Global.byte_array[25] == 1:
		var todda = todda_scn.instance();
		path_follow_2d.offset = randi();
		todda.position = path_follow_2d.position;
		add_child(todda);
#		todda_timer.wait_time( int(rand_range(randi()%(50/Global.byte_array[8]),randi()%(150/Global.byte_array[8])) ));
	todda_timer.start();

func _on_fighter_timer_timeout():
	fighter_timer.wait_time = rand_range(3,10);
	var fighter = fighter_scn.instance();
	path_follow_2d.offset = randi();
	fighter.position = path_follow_2d.position;
	add_child(fighter);
	fighter_timer.start();
