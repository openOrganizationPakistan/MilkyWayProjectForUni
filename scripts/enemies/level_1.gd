extends Node2D

export var virus_scn = preload("res://Scenes/enemies/virus.tscn");

onready var spawn_location = get_node("Path2D/PathFollow2D")

func _ready():
	$Path2D.scale.x = Global.x_ratio;
	

func _on_spawn_timeout():
	$spawn.wait_time = 2 + (randi()%5)
	spawn_location.offset = randi();
	var virus_instance = virus_scn.instance();
	virus_instance.position = spawn_location.position
	add_child(virus_instance)
	pass # Replace with function body.
