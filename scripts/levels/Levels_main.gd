extends Node2D

export (PackedScene) var virus_scn = preload("res://Scenes/enemies/virus.tscn");
export (PackedScene) var boss_scn = preload("res://Scenes/enemies/Boss.tscn");

var boss_timer_started;

onready var virus_timer = $virus;
onready var ship_timer = $ship;
onready var path_follow_2d = $Path2D/PathFollow2D;

func _ready():
	virus_timer.start();

func _process(_delta):
	match Global.byte_array[1]:
		1:
			match Global.byte_array[9]:
#				0:
#					if Global.current_score > 49:
#						Global.byte_array[9] += 1;
#						ship_timer.start();
#				1:
#					if Global.current_score > 149:
#						Global.byte_array[9] += 1;
#						ship_timer.start();
#				2:
#					if Global.current_score > 349:
#						Global.byte_array[9] += 1;
#						ship_timer.start();
#				3:
#					if Global.current_score > 749:
#						virus_timer.stop();
#						_load_boss();
#						Global.byte_array[9] += 1;
#						ship_timer.start();
				0:
					if Global.current_score > 49:
						Global.byte_array[9] +=1;
						virus_timer.stop();
						$boss_commings.start();
			
		0:
			pass;
	

func _on_virus_timeout():
	
	if Global.byte_array[0] == 1:
		queue_free();
	
	if not Global.byte_array[9] == 1:
		virus_timer.wait_time = 2 + rand_range(0,5);
		path_follow_2d.offset = randi();
		var virus_instance = virus_scn.instance();
		virus_instance.position = path_follow_2d.position;
		add_child(virus_instance);
		virus_timer.start();
		
	else:
		pass;
	


func _load_boss():
	var boss = boss_scn.instance();
	path_follow_2d.offset = randi();
	boss.position = path_follow_2d.position;
	add_child(boss);
	

func _on_boss_commings_timeout():
	_load_boss();
