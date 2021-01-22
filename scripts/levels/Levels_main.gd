extends Node2D

export (PackedScene) var virus_scn = preload("res://Scenes/enemies/virus.tscn");
export (PackedScene) var boss_scn = preload("res://Scenes/enemies/Boss.tscn");

onready var virus_timer = $virus;
onready var ship_timer = $ship;
onready var path_follow_2d = $Path2D/PathFollow2D;

func _ready():
	virus_timer.start();
	

func _on_virus_timeout():
	
	if Global.current_score > 49:
		Global.byte_array[1] += 1;
		ship_timer.start();
	
	
	
	virus_timer.wait_time = 2 + rand_range(0,5);
	path_follow_2d.offset = randi();
	var virus_instance = virus_scn.instance();
	virus_instance.position = path_follow_2d.position;
	add_child(virus_instance);
