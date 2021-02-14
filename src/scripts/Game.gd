extends Node2D

var player : Node2D = null
var current_lv : Node2D = null

func _ready():
	player = $Player
	_load_lv($LV1)

func _load_lv(lv_node : Node2D):
	current_lv = lv_node
	player.position = current_lv.get_node("StartPosition").position

func _switch_blizzard(active: bool):
	var animator_group : Array = get_tree().get_nodes_in_group("animator")
	if !animator_group || animator_group.empty():
		return
	var animator_node : AnimationPlayer = animator_group[0]
	if active:
		animator_node.play("blizzard")
	else:
		animator_node.play_backwards("blizzard")

func _is_player(body : Node ) -> bool: 
	return body is KinematicBody2D && body.is_in_group("player")

func _on_BlizzardArea_body_entered(body):
	if _is_player(body):
		_switch_blizzard(true)

func _on_BlizzardArea_body_exited(body):
	if _is_player(body):
		_switch_blizzard(false)
