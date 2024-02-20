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

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_A):
		anim.play("Jump") # make a fall animation?
		if velocity.y >= 0:
			velocity.y -= FLY_OFFEST
		if is_on_floor():
			velocity.y -= JUMP_VELOCITY

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

	var current_score = (int) (-1* position.y) -10
	if current_score > Global.scores[player_index]:
		Global.scores[player_index] = current_score

	move_and_slide()
