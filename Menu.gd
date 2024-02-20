extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://World.tscn")
	pass # Replace with function body.

func _on_options_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
