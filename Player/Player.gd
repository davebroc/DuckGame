extends CharacterBody2D

@export var player_index = 0;
const SPEED = 240.0
const JUMP_VELOCITY = 300.0
const FLY_OFFEST = 11
@onready var anim =  get_node("AnimationPlayer")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass


func actionName(action):
	return action + str(player_index)

func jump():
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_A):
		anim.play("Jump") # make a fall animation?
		if velocity.y >= 0:
			velocity.y -= FLY_OFFEST
		if is_on_floor():
			velocity.y -= JUMP_VELOCITY

func move():
	var direction = Input.get_axis(actionName("left"), actionName("right"))
	if direction != 0:
		scale.x = scale.y * sign(direction)
		# get_node("AnimatedSprite2D").flip_h = direction < 0
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")

func score():
	var current_score = (int) (-1* position.y) -10
	if current_score > Global.scores[player_index]:
		Global.scores[player_index] = current_score


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	jump()
	move()
	score()

	if position.y > 1000:
		position.x = Global.playerStart[player_index][0]
		position.y = Global.playerStart[player_index][1]
		Global.scores[player_index] = 0
	
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_START):
		get_tree().change_scene_to_file("res://Options.tscn")

	move_and_slide()
