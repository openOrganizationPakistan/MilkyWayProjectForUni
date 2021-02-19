#scripts for scores UI showing
extends Container

func _set_score(score_text,score):
	$Label.text = score_text + str(score);
