extends Area2D

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
onready var x_ratio;
onready var y_ratio;

onready var fly_down_timer = $fly_down;
onready var boss_fire_cd = $boss_fire_cd;

func _ready():
	position = Vector2(90,100)
#	scale = Vector2(0.05,0.05) * Global._get_viewport_rect().x
	x_ratio = Global._get_viewport_rect().x/480;
	y_ratio = Global._get_viewport_rect().y/640;
	scale = Vector2(0.75,0.75) * x_ratio;
	h_movement_spd = 5 * x_ratio;
	fly_down_timer.start();
	

func _process(delta):
	if position.x >= 390*x_ratio:
		dir_x = -1;
	elif position.x <= 90*x_ratio:
		dir_x = 1;
	else:
		pass
	
	if fly_down_bool and not anim_done:
		if position.y <=100:
			if position.y < 95:
				position.y = 100;
			dir_y = 1;
			if anim_down_done:
				boss_fire_cd.start();
				fly_down_spd = 0;
				fly_down_timer.start();
				anim_done = true;
		if position.y >= 540:
			dir_y = -1;
			anim_down_done = true
		position.y += fly_down_spd * Global.game_speed * delta * dir_y;
		
	
	position.x += h_movement_spd * Global.game_speed * delta * dir_x;
	

func _on_fly_down_timeout():
	
	boss_fire.queue_free();
	boss_fire_cd.stop();
	fly_down_spd = 50 * y_ratio;
	fly_down_bool = true;
	anim_done = false;
	anim_down_done = false;
	fly_down_timer.wait_time = (rand_range(5,10));
	

func _on_boss_fire_cd_timeout():
	boss_fire = boss_fire_scn.instance();
#	boss_fire.scale = Vector2(20,20);
	boss_fire.position = $laser_gun.position
	boss_fire.rotate(deg2rad(165));
	add_child(boss_fire);
	boss_fire_cd.wait_time = (0.5);
	boss_fire_cd.start();
	
