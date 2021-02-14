extends KinematicBody

var velocity := Vector3.ZERO
var acceleration := 0.1
const SPEED_MAX := 10.0
const ACCELERATION_STEP := 0.1
const FRICTION := 0.9
const JUMP_SPEED := 40.0
const WEIGHT := 6.0
var player_sprite: AnimatedSprite3D = null
var particles: CPUParticles2D = null
onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector").y


func _ready():
	pass
	player_sprite = $AnimatedSprite3D
	# particles = $DeathParticles


func _physics_process(delta : float):
	# Apply gravity.
	velocity.y += delta * gravity * WEIGHT

	var input := Vector2.ZERO
	if Input.is_action_pressed("right"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.x -= 1
#	if Input.is_action_pressed("down"):
#		input.y -= 1
	if Input.is_action_pressed("up"):
		input.y += 1
	_move_player(input.normalized())
	_anim_player(input.normalized())


func _move_player(input: Vector2):
	if input != Vector2.ZERO:
		if acceleration < 1:
			acceleration += ACCELERATION_STEP
	else:
		if acceleration > 0.1:
			acceleration -= ACCELERATION_STEP * 2

	if input.x != 0:
		velocity.x = input.x * SPEED_MAX * acceleration
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	if input.y > 0 && is_on_floor():
		velocity.y = JUMP_SPEED

	velocity = move_and_slide(velocity, Vector3.UP)
	#var collide = move_and_collide(velocity, true, true, true)
	#if collide:
	#	print(collide.collider_id)


func _anim_player(input: Vector2):
	if not is_on_floor():
		if velocity.y >= 0 && player_sprite.animation != "jump_up":
			player_sprite.play("jump_up")
		elif velocity.y < 0 && player_sprite.animation != "jump_down":
			player_sprite.play("jump_down")
	elif input != Vector2.ZERO:
		player_sprite.play("run")
	else:
		player_sprite.play("idle")

	if input.x != 0:
		if velocity.x >= 0.01:
			player_sprite.flip_h = true
		elif velocity.x < 0:
			player_sprite.flip_h = false


func hurt(degat: float):
	if Globals.life <= 0:
		return
	Globals.life -= degat
	if Globals.life <= 0:
		Globals.life = 0
		killPlayer()


func killPlayer():
	set_physics_process(false)
	player_sprite.play("death")
	Globals.dialog = "Defeat..."


func victory():
	# get_tree().call_group("egg", "hide")
	# var nest_node = get_tree().get_nodes_in_group("nest")[0]
	set_physics_process(false)
	player_sprite.play("victory")
	Globals.life = 0.0
	Globals.dialog = "Victory !"


func _on_animation_finished():
	if player_sprite.animation == "victory":
		player_sprite.stop()
		player_sprite.frame = player_sprite.frames.get_frame_count("victory")
	if player_sprite.animation == "death":
		player_sprite.stop()
		particles.emitting = true
		player_sprite.visible = false
