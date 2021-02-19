#players_main
extends Node2D

func _get_player(index):
#	var j = get_child_count()
#	for i in j:
#		if i!=index:
#			get_child(i).queue_free();
	
	return get_child(index).duplicate();
