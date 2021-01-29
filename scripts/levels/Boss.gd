extends Area2D
#extends "res://scripts/Players/player_controls.gd" #its for testing during development process.

export (PackedScene) var boss_fire_scn = preload("res://Scenes/Attacks/Boss_Fire.tscn");

var dir_x = 1;
var dir_y = 1;

var fly_down_spd = 0;

var scr_touch = false;
var fly_down_bool = false;
var anim_done = false;
var anim_down_done = false;

var boss_fire;
var h_movement_spd;
var health;

onready var fly_down_timer = $fly_down;
onready var boss_fire_cd = $boss_fire_cd;

func _ready():
	scale = (Vector2(0.85,0.85) * Global.x_ratio);
	position = Vector2(128*scale.x,128*scale.y);
	h_movement_spd = 0.1 * Global.x_ratio;
	fly_down_timer.start();
	health = Global.boss_health;
#	connect("area_entered",self,"_on_area_entered")
#	health =0;

func _process(_delta):
	
	if position.x >= 390*Global.x_ratio:
		dir_x = -1;
	elif position.x <= 90*Global.x_ratio:
		dir_x = 1;
	

	if fly_down_bool and not anim_done:
		if position.y <=0b1100010*Global.y_ratio:
			if position.y < 0b1100000*Global.y_ratio:
				position.y = 0b1100010*Global.y_ratio;
			dir_y = 1;
			if anim_down_done:
				boss_fire_cd.start();
				fly_down_spd = 0;
				fly_down_timer.start();
				anim_done = true;
		if position.y >= 540*Global.y_ratio:
			dir_y = -1;
			anim_down_done = true
		position.y += fly_down_spd * Global.byte_array[8]  * dir_y;


	position.x += h_movement_spd * Global.byte_array[8] * dir_x;


func _on_fly_down_timeout():
	
	boss_fire_cd.stop();
	fly_down_spd = 0.5 *Global.y_ratio;
	fly_down_bool = true;
	anim_done = false;
	anim_down_done = false;
	fly_down_timer.wait_time = (rand_range(5,10));
	

func _on_boss_fire_cd_timeout():
	boss_fire = boss_fire_scn.instance();
	boss_fire.position = $laser_gun.position;
	boss_fire.rotation = deg2rad(155);
	add_child(boss_fire);
	boss_fire_cd.wait_time = (rand_range(1,3));
	boss_fire_cd.start();
	

func _on_Boss_area_entered(area):

	if health <= 0:
		dir_x=0;
		dir_y = 0;
		fly_down_timer.stop();
		boss_fire_cd.stop();
		$sprite.hide();
		$distroy.show();
		$distroy.play("destroyed");
		$shape.set_deferred("disabled",true);
		rotation += deg2rad(1);
		Global.current_score += 1000;

	elif area.is_in_group("player_fire"):
		
		health -= int(Global.byte_array[5])	# Global.player_fire_damage
		Global.enemy_c_health = health
		


func _on_distroy_animation_finished():
	
	if ( (Global.current_score ) >= int(Global.high_score) ):
			Global._set_h_s( (Global.current_score) );
		
	Global.byte_array[0] = 1; # game_over == 1
	queue_free();
	

