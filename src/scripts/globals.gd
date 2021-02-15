extends Node

var default_life := 3.0
var life := default_life
var dialog := ""
var DEBUG := OS.is_debug_build()

func _ready():
	randomize()

func restart_game():
	life = default_life
	dialog = ""
	goto_scene("MainMenu")

func goto_scene(new_scene_name : String):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/scenes/" + new_scene_name + ".tscn")
