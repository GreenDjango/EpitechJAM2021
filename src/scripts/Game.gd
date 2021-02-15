extends Node2D

var is_end := false
var player : Node2D = null
var current_lv : Node2D = null
var time_label : RichTextLabel = null

func _ready():
	player = $Player
	time_label = $CanvasLayer/TimeLabel
	_load_lv($LV1)
	

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed == true && event.echo == false:
			_change_state(event.scancode)
		if is_end && event.is_action_pressed("accept"):
			Globals.restart_game()


func _change_state(scancode : int):
	var past : Node2D = current_lv.get_node("Visual/Past")
	var future : Node2D = current_lv.get_node("Visual/Future")

	if scancode == KEY_1 || scancode == KEY_KP_1:
		player.state = player.PAST
		past.visible = true
		future.visible = false
		time_label.bbcode_text = "[ghost freq=2.0 span=3.0]Past[/ghost]"
	if scancode == KEY_2 || scancode == KEY_KP_2:
		player.state = player.PRESENT
		past.visible = false
		future.visible = false
		time_label.bbcode_text = "[ghost freq=2.0 span=3.0]Presente[/ghost]"
	if scancode == KEY_3 || scancode == KEY_KP_3:
		player.state = player.FUTURE
		past.visible = false
		future.visible = true
		time_label.bbcode_text = "[ghost freq=2.0 span=3.0]Future[/ghost]"


func _load_lv(lv_node : Node2D):
	if current_lv:
		if current_lv.get_node("EndZone").is_connected("body_entered", self, "_on_end"):
			current_lv.get_node("EndZone").disconnect("body_entered", self, "_on_end")
	current_lv = lv_node
	player.position = current_lv.get_node("StartPosition").position
	current_lv.get_node("Visual/Past").visible = false
	current_lv.get_node("Visual/Future").visible = false
	# warning-ignore:return_value_discarded
	current_lv.get_node("EndZone").connect("body_entered", self, "_on_end")

func _on_end(body : Node):
	if not is_end && _is_player(body):
		Globals.dialog = "[center]You won\nPress Enter[/center]"
		is_end = true


func _is_player(body : Node ) -> bool: 
	return body is KinematicBody2D && body.is_in_group("player")
