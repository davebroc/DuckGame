extends CharacterBody2D


const SPEED = 240.0
const JUMP_VELOCITY = 300.0
const FLY_OFFEST = 11
@onready var anim =  get_node("AnimationPlayer")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("ui_accept"):
		anim.play("Jump") # make a fall animation?
		if velocity.y >= 0:
			velocity.y -= FLY_OFFEST
		if is_on_floor():
			velocity.y -= JUMP_VELOCITY
	
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		get_node("AnimatedSprite2D").flip_h = !((direction + 1) / 2) 
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
		
	move_and_slide()
