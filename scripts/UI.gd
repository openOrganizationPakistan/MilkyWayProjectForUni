extends Container


func _ready():
	$VBoxContainer.rect_global_position = ((Vector2(480,640) * Global.x_ratio) /2) - $VBoxContainer.rect_size/2
	$CPUParticles2D.position.x = 240*Global.x_ratio;
	$CPUParticles2D.emission_rect_extents.x = 240*Global.x_ratio;


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Main_Scene.tscn")
	pass # Replace with function body.
