#script: player_01
extends "res://scripts/Players/player_controls.gd"

export (PackedScene) var main_fires_scn = preload("res://Scenes/Attacks/Player_Fires_Main.tscn");
export (PackedScene) var hearts_tex_scn = preload("res://Scenes/Miscs/heart_tex.tscn");

var temp_fire = main_fires_scn.instance();
onready var hearts_loc = get_tree().get_root().find_node("heartsContainer",true,false);

func _ready():
	Global.byte_array[37] = 0;
	scale = (Vector2(0.4,0.4) * Global.x_ratio);
	Global.byte_array[6] = Global.byte_array[4]; # player current health's global status
	_spawned();
	for i in (Global.byte_array[26] - 5 ):
		var test = hearts_tex_scn.instance();
		hearts_loc.add_child(test);
		i+=1;

func _spawned():
	$shape.set_deferred("disabled",true);
	$Timer.start();

func _on_Player_01_area_entered(area):
	if area.is_in_group("boss"):
		Global.byte_array[6] -= Global.byte_array[3];
	if area.is_in_group("boss_fire"):
		Global.byte_array[6] -= Global.byte_array[10];
	if area.is_in_group("virus"):
		Global.byte_array[6] -= Global.byte_array[11]; 
	if area.is_in_group("todda"):
		Global.byte_array[6] -= Global.byte_array[21];
	if area.is_in_group("fighter"):
		Global.byte_array[6] -= Global.byte_array[28];
	if area.is_in_group("enemy_fire"):
		Global.byte_array[6] -= Global.byte_array[29];
	if Global.byte_array[6] < 51 :
		Global.byte_array[36] = 0;
		$shape.set_deferred("disabled",true);
		$sprite.hide();
		$distroy.show();
		$distroy.play("destroyed-ulq");
		if not (get_tree().get_root().find_node("heartsContainer",true,false).get_child_count()<1):
			hearts_loc.remove_child(hearts_loc.get_child(0));
	
func _on_distroy_animation_finished():
	Global.byte_array[26] -= 1;
	if Global.byte_array[26] < 5:
		if ( Global.current_score  >= int(Global.high_score) ):
			Global._set_h_s( (Global.current_score ) );
			Global.byte_array[37] = 1;
		Global.byte_array[0] = 1;
	else:
		Global.byte_array[6] = Global.byte_array[4];
		Global.byte_array[36] = 1;
		$sprite.show();
		$distroy.hide();
		$distroy.stop();
		global_position = Vector2(Global._get_viewport_rect().x/2,Global._get_viewport_rect().y);
		Global.byte_array[27] = 5;
		_spawned();
	
func _on_Timer_timeout():
	$shape.set_deferred("disabled",false);
