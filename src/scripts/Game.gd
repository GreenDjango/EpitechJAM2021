extends Node2D

var player : Node2D = null
var current_lv : Node2D = null

func _ready():
	player = $Player
	_load_lv($LV1)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed == true && event.echo == false:
			_change_state(event.scancode)


func _change_state(scancode : int):
	var past : Node2D = current_lv.get_node("Visual/Past")
	var future : Node2D = current_lv.get_node("Visual/Future")

	if scancode == KEY_1:
		player.state = player.PAST
		past.visible = true
		future.visible = false
	if scancode == KEY_2:
		player.state = player.PRESENT
		past.visible = false
		future.visible = false
	if scancode == KEY_3:
		player.state = player.FUTURE
		past.visible = false
		future.visible = true


func _load_lv(lv_node : Node2D):
	#if current_lv:
	#	current_lv.get_node("EndZone").disconnect("body_entered")
	current_lv = lv_node
	player.position = current_lv.get_node("StartPosition").position
	current_lv.get_node("Visual/Past").visible = false
	current_lv.get_node("Visual/Future").visible = false
	#current_lv.get_node("EndZone").connect("body_entered", self, "_on_end")

func _on_end():
	print("END")


func _is_player(body : Node ) -> bool: 
	return body is KinematicBody2D && body.is_in_group("player")
